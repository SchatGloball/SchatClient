import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../eventStore.dart';

class AudioPage extends StatefulWidget {
  final String urlAudio;
  
  const AudioPage({
    super.key,
    required this.urlAudio,
  });
  
  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> with TickerProviderStateMixin {
  bool _isPlaying = false;
  bool _isLoading = false;
  String _recordingDuration = '00:00';
  String _fileName = '';
  late AnimationController _progressController;
  Timer? _timer;
  int _currentSeconds = 0;
  int _totalSeconds = 0;
  String _fileType = 'unknown';
  StreamSubscription? _playerCompleteSubscription;
  bool _disposed = false; // Флаг для отслеживания состояния dispose
  
  @override
  void initState() {
    super.initState();
    _fileName = _extractFileName(widget.urlAudio);
    _fileType = _getFileType(widget.urlAudio);
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }
  
  @override
  void dispose() {
    _disposed = true; // Устанавливаем флаг, что dispose вызван
    _playerCompleteSubscription?.cancel();
    _timer?.cancel();
    _progressController.dispose();
 
    super.dispose();
  }
  
  String _extractFileName(String url) {
    try {
      final parts = url.split('.separated.');
      if (parts.length > 1) {
        return parts.last.split('.').first;
      }
      return 'Аудио';
    } catch (e) {
      return 'Аудио';
    }
  }
  
  String _getFileType(String url) {
    final String lowerUrl = url.toLowerCase().split('?x-amz-algorithm').first;
    if (lowerUrl.endsWith('.wav')) return 'wav';
    if (lowerUrl.endsWith('.mp3')) return 'mp3';
    if (lowerUrl.endsWith('.m4a') || lowerUrl.endsWith('.aac')) return 'aac';
    if (lowerUrl.endsWith('.ogg') || lowerUrl.endsWith('.oga')) return 'ogg';
    if (lowerUrl.endsWith('.flac')) return 'flac';
    return 'unknown';
  }
  
  Future<void> _detectAudioFormat() async {
    try {
      final bytes = await _fetchFirstBytes(128);
      
      if (bytes.length >= 12) {
        final riff = String.fromCharCodes(bytes.sublist(0, 4));
        final wave = String.fromCharCodes(bytes.sublist(8, 12));
        if (riff == 'RIFF' && wave == 'WAVE') {
          _fileType = 'wav';
          return;
        }
      }
      
      if (bytes.length >= 3) {
        if (bytes[0] == 0xFF && (bytes[1] & 0xE0) == 0xE0) {
          _fileType = 'mp3';
          return;
        }
      }
      
      if (bytes.length >= 4) {
        if (String.fromCharCodes(bytes.sublist(0, 4)) == 'fLaC') {
          _fileType = 'flac';
          return;
        }
        if (String.fromCharCodes(bytes.sublist(0, 4)) == 'OggS') {
          _fileType = 'ogg';
          return;
        }
      }
    } catch (e) {
      debugPrint('Ошибка определения формата: $e');
    }
  }
  
  Future<Uint8List> _fetchFirstBytes(int count) async {
    try {
      if (config.isWeb) {
        final response = await http.get(
          Uri.parse(widget.urlAudio),
          headers: {'Range': 'bytes=0-${count - 1}'},
        );
        if (response.statusCode == 200 || response.statusCode == 206) {
          return response.bodyBytes;
        }
      } else {
        final client = HttpClient();
        try {
          final request = await client.getUrl(Uri.parse(widget.urlAudio));
          request.headers.set(HttpHeaders.rangeHeader, 'bytes=0-${count - 1}');
          final response = await request.close();
          final bytes = await response.fold<Uint8List>(
            Uint8List(count), (data, chunk) {
              final offset = data.length - response.contentLength;
              for (var i = 0; i < chunk.length && offset + i < count; i++) {
                data[offset + i] = chunk[i];
              }
              return data;
            },
          );
          return bytes;
        } finally {
          client.close();
        }
      }
    } catch (e) {
      debugPrint('Ошибка получения байтов: $e');
    }
    return Uint8List(0);
  }
  
  Future<int> _getAudioDuration() async {
    try {
      if (_fileType == 'unknown') {
        await _detectAudioFormat();
      }
      
      int fileSize = 0;
      
      if (config.isWeb) {
        try {
          final response = await http.get(
            Uri.parse(widget.urlAudio),
            headers: {'Range': 'bytes=0-100'},
          );
          
          final contentRange = response.headers['content-range'];
          if (contentRange != null) {
            final sizeMatch = RegExp(r'/(\d+)$').firstMatch(contentRange);
            if (sizeMatch != null) {
              fileSize = int.parse(sizeMatch.group(1)!);
            }
          }
          
          if (fileSize == 0) {
            final contentLength = response.headers['content-length'];
            if (contentLength != null) {
              fileSize = int.parse(contentLength);
            }
          }
        } catch (e) {
          debugPrint('Web: ошибка получения размера: $e');
        }
      } else {
        final client = HttpClient();
        try {
          final request = await client.getUrl(Uri.parse(widget.urlAudio));
          request.headers.set(HttpHeaders.rangeHeader, 'bytes=0-100');
          final response = await request.close();
          
          final contentRange = response.headers.value(HttpHeaders.contentRangeHeader);
          if (contentRange != null) {
            final sizeMatch = RegExp(r'/(\d+)$').firstMatch(contentRange);
            if (sizeMatch != null) {
              fileSize = int.parse(sizeMatch.group(1)!);
            }
          }
          
          response.drain<void>();
        } catch (e) {
          debugPrint('Native: ошибка получения размера: $e');
        } finally {
          client.close();
        }
      }
      
      debugPrint('Определенный размер файла: $fileSize байт');
      
      if (fileSize <= 0) {
        debugPrint('Используем приблизительную оценку длительности');
        return 30;
      }
      
      switch (_fileType) {
        case 'wav':
          return await _calculateWavDuration(fileSize);
        case 'mp3':
          return await _calculateMp3Duration(fileSize);
        default:
          return _estimateDuration(fileSize);
      }
    } catch (e) {
      debugPrint('Ошибка получения длительности: $e');
      return 30;
    }
  }
  
  Future<int> _calculateWavDuration(int fileSize) async {
    try {
      final bytes = await _fetchFirstBytes(44);
      if (bytes.length < 44) return _estimateDuration(fileSize);
      
      final data = ByteData.sublistView(bytes);
      
      final riff = String.fromCharCodes(bytes.sublist(0, 4));
      final wave = String.fromCharCodes(bytes.sublist(8, 12));
      if (riff != 'RIFF' || wave != 'WAVE') return _estimateDuration(fileSize);
      
      final audioFormat = data.getUint16(20, Endian.little);
      if (audioFormat != 1) return _estimateDuration(fileSize);
      
      final numChannels = data.getUint16(22, Endian.little);
      final sampleRate = data.getUint32(24, Endian.little);
      final bitsPerSample = data.getUint16(34, Endian.little);
      
      final audioDataSize = fileSize - 44;
      final bytesPerSecond = sampleRate * numChannels * (bitsPerSample ~/ 8);
      
      return bytesPerSecond > 0 ? (audioDataSize / bytesPerSecond).ceil() : 30;
    } catch (e) {
      debugPrint('Ошибка расчета WAV длительности: $e');
      return _estimateDuration(fileSize);
    }
  }
  
  Future<int> _calculateMp3Duration(int fileSize) async {
    try {
      final bytes = await _fetchFirstBytes(4096);
      
      int totalBitrate = 0;
      int frameCount = 0;
      
      for (int i = 0; i < bytes.length - 3; i++) {
        if (bytes[i] == 0xFF && (bytes[i + 1] & 0xE0) == 0xE0) {
          final header = (bytes[i] << 24) | (bytes[i + 1] << 16) | (bytes[i + 2] << 8) | bytes[i + 3];
          final bitrateIndex = (header >> 12) & 0x0F;
          final layer = (header >> 17) & 0x03;
          
          const bitrates = [
            [0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448],
            [0, 32, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 384],
            [0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320],
          ];
          
          if (layer >= 1 && layer <= 3 && bitrateIndex > 0 && bitrateIndex < 15) {
            totalBitrate += bitrates[layer - 1][bitrateIndex];
            frameCount++;
          }
        }
      }
      
      if (frameCount > 0 && totalBitrate > 0) {
        final averageBitrate = totalBitrate ~/ frameCount;
        final duration = (fileSize * 8 / 1000 / averageBitrate).ceil();
        debugPrint('MP3: averageBitrate=$averageBitrate kbps, duration=$duration s');
        return duration;
      }
      
      return (fileSize * 8 / 1000 / 128).ceil();
    } catch (e) {
      debugPrint('Ошибка расчета MP3 длительности: $e');
      return _estimateDuration(fileSize);
    }
  }
  
  int _estimateDuration(int fileSize) {
    switch (_fileType) {
      case 'mp3':
        return (fileSize * 8 / 1000 / 128).ceil();
      case 'wav':
        return (fileSize / 16000).ceil();
      case 'aac':
        return (fileSize * 8 / 1000 / 96).ceil();
      case 'ogg':
        return (fileSize * 8 / 1000 / 112).ceil();
      case 'flac':
        return (fileSize / 24000).ceil();
      default:
        return (fileSize / 16000).ceil();
    }
  }
  
  void _startTimer() {
    _timer?.cancel();
    _currentSeconds = 0;
    _updateDurationDisplay();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_disposed) {
        timer.cancel();
        return;
      }
      
      if (_currentSeconds >= _totalSeconds) {
        _onPlaybackComplete();
        return;
      }
      
      // Проверяем disposed перед setState
      if (!_disposed && mounted) {
        setState(() {
          _currentSeconds++;
          _updateDurationDisplay();
          _progressController.value = _currentSeconds / _totalSeconds;
        });
      } else {
        timer.cancel();
      }
    });
  }
  
  void _updateDurationDisplay() {
    // Проверяем, не был ли уже вызван dispose
    if (_disposed || !mounted) return;
    
    final minutes = (_currentSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_currentSeconds % 60).toString().padLeft(2, '0');
    
    // Не вызываем setState здесь, просто обновляем переменную
    // Вызов setState будет в вызывающем методе
    _recordingDuration = '$minutes:$seconds';
  }
  
  void _onPlaybackComplete() {
    _timer?.cancel();
    // Проверяем disposed перед setState
    if (!_disposed && mounted) {
      setState(() {
        _isPlaying = false;
        _currentSeconds = _totalSeconds;
        _recordingDuration = '${(_totalSeconds ~/ 60).toString().padLeft(2, '0')}:${(_totalSeconds % 60).toString().padLeft(2, '0')}';
        _progressController.value = 1.0;
      });
    }
  }
  
  void _stopAudio() {
    // Проверяем disposed
    if (_disposed) return;
    
    player.player.stop();
    
    // Отменяем таймер
    _timer?.cancel();
    _timer = null;
    
    // Анимацию выполняем только если виджет еще жив
    if (mounted) {
      _progressController.animateTo(0.0, duration: const Duration(milliseconds: 300));
    }
    
    // Обновляем состояние только если виджет еще жив
    if (!_disposed && mounted) {
      setState(() {
        _isPlaying = false;
        _currentSeconds = 0;
        _recordingDuration = '00:00';
        _progressController.value = 0.0;
      });
    }
  }
  
  Future<void> _togglePlayback() async {
    // Проверяем disposed
    if (_disposed) return;
    
    if (_isPlaying) {
      _stopAudio();
      return;
    }
    
    if (_totalSeconds == 0) {
      if (!_disposed && mounted) {
        setState(() => _isLoading = true);
      }
      
      try {
        print('fdhbfdhfdhjfjdjdf');
        _totalSeconds = await _getAudioDuration();
        
        // Проверяем disposed после асинхронной операции
        if (_disposed || !mounted) return;
        
        _progressController.duration = Duration(seconds: _totalSeconds);
        
        await player.playWebSound(widget.urlAudio);
        
        // Отменяем предыдущую подписку, если есть
        _playerCompleteSubscription?.cancel();
        _playerCompleteSubscription = player.player.onPlayerComplete.listen((_) {
          // Проверяем disposed в callback
          if (!_disposed && mounted) {
            _onPlaybackComplete();
          }
        });
        
        // Проверяем disposed перед setState
        if (!_disposed && mounted) {
          setState(() {
            _isPlaying = true;
            _isLoading = false;
          });
        }
        
        _startTimer();
        _progressController.forward();
      } catch (e) {
        debugPrint('Ошибка воспроизведения: $e');
        if (!_disposed && mounted) {
          setState(() => _isLoading = false);
        }
      }
    } else {
      await player.playWebSound(widget.urlAudio);
      
      // Проверяем disposed перед setState
      if (!_disposed && mounted) {
        setState(() => _isPlaying = true);
      }
      _startTimer();
      _progressController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(config.containerRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: _isPlaying
                  ? [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: IconButton(
              onPressed: _isLoading ? null : _togglePlayback,
              icon: _isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          config.accentColor,
                        ),
                      ),
                    )
                  : Icon(
                      _isPlaying ? Icons.stop : Icons.play_arrow,
                      size: 20,
                    ),
              color: _isPlaying ? Colors.red : config.accentColor,
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 36,
              ),
              iconSize: 20,
            ),
          ),
          
          const SizedBox(width: 12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    _getFormatIcon(),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '$_fileName.${_fileType != 'unknown' ? _fileType : ''}',
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),
                
                Row(
                  children: [
                    Text(
                      _recordingDuration,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                    
                    const SizedBox(width: 8),
                    
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: _progressController.value,
                          valueColor: AlwaysStoppedAnimation<Color>(config.accentColor),
                          minHeight: 4,
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 8),
                    
                    if (_totalSeconds > 0)
                      Text(
                        '${(_totalSeconds ~/ 60).toString().padLeft(2, '0')}:${(_totalSeconds % 60).toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _getFormatIcon() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _fileType.toUpperCase(),
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}