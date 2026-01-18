import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../DataClasses/file.dart';
import '../eventStore.dart';


class AudioRecorderPage extends StatefulWidget {
  late int chatId;
  final VoidCallback updateParent;
  AudioRecorderPage({super.key, required this.chatId, required this.updateParent});

  @override
  State<AudioRecorderPage> createState() => _AudioRecorderPage(chatId: chatId);
}

class _AudioRecorderPage extends State<AudioRecorderPage>
    with TickerProviderStateMixin {
  late int chatId;
  _AudioRecorderPage({required this.chatId});

  final record = AudioRecorder();
  String voiceRecordTime = '0:00';
  bool send = false;
  List<int> data = [];
  FileData recordFile = FileData('sound', [], 'sound.wav');
  @override
  void initState() {
    super.initState();
    startRecord();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  startRecord() async {
    if (await record.hasPermission()) {
      final Stream<Uint8List> stream = await record.startStream(
          const RecordConfig(
              encoder: AudioEncoder.pcm16bits, numChannels: 1, bitRate: 88200));
      stream.listen((item) {
        data.addAll(item);
      });
    }
    setState(() {
      recordAudio = true;
    });
    timerRecording(-1);
  }

  saveAsWav() async {
    int fileSize = data.length + 44; // Add 44 bytes for WAV header
    List<int> header = [
      0x52, 0x49, 0x46, 0x46, // "RIFF"
      fileSize & 0xFF,
      (fileSize >> 8) & 0xFF,
      (fileSize >> 16) & 0xFF,
      (fileSize >> 24) & 0xFF,
      0x57, 0x41, 0x56, 0x45, // "WAVE"
      0x66, 0x6d, 0x74, 0x20, // "fmt "
      0x10, 0x00, 0x00, 0x00, // Size of subchunk (16 bytes)
      0x01, 0x00, // Audio format (1 - PCM)
      0x01, 0x00, // Number of channels (1 - mono)
      0x44, 0xAC, 0x00, 0x00, // Sample rate (44100 Hz)
      0x88, 0x58, 0x01, 0x00, // Byte rate (44100 * 2 = 88200 bytes/s)
      0x02, 0x00, // Block align (2 bytes per sample)
      0x10, 0x00, // Bits per sample (16 bits)
      0x64, 0x61, 0x74, 0x61, // "data"
      data.length & 0xFF,
      (data.length >> 8) & 0xFF,
      (data.length >> 16) & 0xFF,
      (data.length >> 24) & 0xFF,
    ];
    recordFile.data = header + data;
  }

  timerRecording(int seconds) {
    if (!recordAudio) {
      return;
    }

    String s = '';
    String m = '';
    seconds += 1;
    int minutes = 0;
    if (seconds > 59) {
      minutes = seconds ~/ 60;
    }
    if (seconds % 60 > 9) {
      s = '${seconds % 60}';
    } else {
      s = '0${seconds % 60}';
    }
    if (minutes > 9) {
      m = '${minutes % 60}';
    } else {
      m = '0${minutes % 60}';
    }

    setState(() {
      voiceRecordTime = '$m:$s';
    });
    return Future.delayed(
        const Duration(seconds: 1), () => timerRecording(seconds));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = constraints.maxWidth;
        final parentHeight = constraints.maxHeight;
        return SizedBox(
            width: parentWidth,
            height: parentHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: parentWidth / 6,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    color: Colors.amber,
                    style: TextButton.styleFrom(foregroundColor: Colors.amber),
                    icon: const Icon(
                      Icons.mic,
                      size: 40,
                    ),
                    tooltip: 'Increase volume by 10',
                    onPressed: () {},
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 6),
                    height: MediaQuery.of(context).size.height / 10,
                    width: parentWidth / 1.7,
                    child: Container(
                        padding: const EdgeInsets.only(left: 6),
                        height: MediaQuery.of(context).size.height / 10,
                        width: parentWidth / 1.7,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(voiceRecordTime,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold, // Жирный шрифт
                                  )),
                              Container(
                                  width: parentWidth / 6,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: InkWell(
                                    onTap: () async {
                                      await record.stop();
                                    setState(() {
                                    recordAudio = false;  
                                    widget.updateParent();
                                    });
                                    },
                                    child: const Icon(
                                      Icons.highlight_remove_rounded,
                                      size: 40,
                                    ),
                                  )),
                            ],
                          ),
                        ))),
                Container(
                  width: parentWidth / 6,
                  height: MediaQuery.of(context).size.height * 0.14 -
                      kToolbarHeight,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: InkWell(
                    onTap: () async {
                      await record.stop();
                      await saveAsWav();
                      Map res = await config.server.chatApi
                          .sendMessages(chatId, 'audio', [recordFile]);
                          setState(() {
                             recordAudio = false;
                          });
                    },
                    child: const Icon(
                      Icons.send,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
