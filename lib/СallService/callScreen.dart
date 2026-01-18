import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_voice_processor/flutter_voice_processor.dart';
import 'package:mp_audio_stream/mp_audio_stream.dart';
import '../DataClasses/callData.dart';
import '../eventStore.dart';
import '../generated/call.pb.dart';




class CallPage extends StatefulWidget
{
  Call  call;
   CallPage({required this.call, super.key});

  @override
  State<CallPage> createState() => _CallPage(call: call);
}

class _CallPage extends State<CallPage> {

  Call  call;
  _CallPage({required this.call});

 bool connect = false;
  StreamController<RequestDto> controller = StreamController<RequestDto>();

    final int frameLength = 512;
  final int sampleRate = 16000;

  final int volumeHistoryCapacity = 5;
  final double dbOffset = 50.0;
  final List<double> _volumeHistory = [];
  double _smoothedVolumeValue = 0.0;
  bool voice = false;
  bool _isProcessing = false;
  String? _errorMessage;
  VoiceProcessor? _voiceProcessor;
  late StreamSubscription<UpdateDTO> listenSound;
  
  @override
  void initState() {
    print(call.users.length);
        audioStream.init(channels: 1, sampleRate: sampleRate); 
  _initVoiceProcessor();
    super.initState();
    if(activeCall == call.id)
    {
 voiceSpeak();
    }
    else
    {
player.playCall();  
    }
    activeCall = call.id;

  }


  @override
  void dispose() {
  _voiceProcessor?.removeFrameListener(_onFrame);
  _voiceProcessor?.removeErrorListener(_onError);
  _voiceProcessor?.stop();
  if (!controller.isClosed) {
    controller.close();
  }
    audioStream.uninit();
    activeCall = '';
    super.dispose();
  }



    
  void _initVoiceProcessor() async {
    _voiceProcessor = VoiceProcessor.instance;
  }

  Future<void> _startProcessing() async {
    setState(() {
      connect = true;
      Future.delayed(const Duration(seconds: 2), () => voice = true);
    });
    _voiceProcessor?.addFrameListener(_onFrame);
    _voiceProcessor?.addErrorListener(_onError);
    try {
      if (await _voiceProcessor?.hasRecordAudioPermission() ?? false) {
        await _voiceProcessor?.start(frameLength, sampleRate);
        bool? isRecording = await _voiceProcessor?.isRecording();
        setState(() {
          _isProcessing = isRecording!;
        });
      } else {
        setState(() {
          _errorMessage = "Recording permission not granted";
        });
      }
    } on PlatformException catch (ex) {
      setState(() {
        _errorMessage = "Failed to start recorder: " + ex.toString();
      });
    } finally {
      setState(() {
        voice = false;
      });
    }
  }

  Future<void> _stopProcessing() async {
    setState(() {
      voice = true;
    });

    try {
      await _voiceProcessor?.stop();
    } on PlatformException catch (ex) {
      setState(() {
        _errorMessage = "Failed to stop recorder: " + ex.toString();
      });
    } finally {
      bool? isRecording = await _voiceProcessor?.isRecording();
      setState(() {
        voice = false;
        _isProcessing = isRecording!;
      });
    }
  }

  void _toggleProcessing() async {
    if (_isProcessing) {
      await _stopProcessing();
    } else {
      await _startProcessing();
    }
  }

  double _calculateVolumeLevel(List<int> frame) {
    double rms = 0.0;
    for (int sample in frame) {
      rms += pow(sample, 1);
    }
    rms = sqrt(rms / frame.length);

    double dbfs = 20 * log(rms / 32767.0) / log(10);
    double normalizedValue = (dbfs + dbOffset) / dbOffset;
    return normalizedValue.clamp(0.0, 1.0);
  }

  void _onFrame(List<int> frame) {
    if(voice)
    {
 controller.add(RequestDto(room: call.id, callData: CallDto(soundData: frame, videoData: [])));
    }
    double volumeLevel = _calculateVolumeLevel(frame);
    if (_volumeHistory.length == volumeHistoryCapacity) {
      _volumeHistory.removeAt(0);
    }
    _volumeHistory.add(volumeLevel);

    setState(() {
      _smoothedVolumeValue =
          _volumeHistory.reduce((a, b) => a + b) / _volumeHistory.length;
    });
  }

  void _onError(VoiceProcessorException error) {
    setState(() {
      _errorMessage = error.message;
    });
  }



  findUser()async
  {
    // Map res = await userApi.searchUser(userName);
    // if (res.keys.first != 'Error' && res['users'].isNotEmpty) {
    //   for(var userFind in res['users'])
    //   {
    //     if(userFind.username == userName)
    //     {
    //       setState(() {
    //         user = User(userFind.id, userFind.username,
    //             userFind.imageAvatar);
    //       });
    //     }
    //   }
    // }
  }


final audioStream = getAudioStream();
  voiceSpeak()async
  {
connect = true;
    

_startProcessing();
    
    Stream<UpdateDTO> voiceStream = config.server.callApi.enterToRoom(controller.stream);
    listenSound = voiceStream.listen((update) async {
      if(update.exitCall)
      { 
        listenSound.cancel();
        Navigator.pop(context);
      return;
      
      }
if (update.callData.soundData.isNotEmpty) {
      final Float32List floatSamples = Float32List(update.callData.soundData.length);
      for (int i = 0; i < update.callData.soundData.length; i++) {
  floatSamples[i] = update.callData.soundData[i] / 32767.0;
}
      audioStream.push(floatSamples);
    } else {
      print("Received empty soundData list for this update.");
    }
    },);
  }



  @override
  Widget build(BuildContext context) {
    return
      Stack(
          children: [
            Image.asset(
              'assets/${config.backgroundAsset}',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),

            Scaffold(
              appBar: AppBar(
                backgroundColor: config.accentColor,
                leading: BackButton(
                    onPressed: (){
                      Navigator.of(context).pop();}
                ),
                automaticallyImplyLeading: false,
              ),
              backgroundColor: Colors.transparent,
              body: ListView(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height*0.6,
                      child: ListView.builder(
                    itemCount: call.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black54,
                              ),
                              child: Column(
                                children: [
                                  const Padding(padding: EdgeInsets.all(5)),
                                  Row(
                                    children: [
                                      const Padding(padding: EdgeInsets.all(5)),
                                      if (call.users[index].imageAvatar == '' ||
                                          call.users[index].imageAvatar == 'null')
                                        CircleAvatar(
                                          child: Icon(
                                              color:
                                              config.accentColor,
                                              Icons.person),
                                        ),
                                      if (call.users[index].imageAvatar.toString() !=
                                          'null' &&
                                          call.users[index].imageAvatar.toString() !=
                                              '')
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              call.users[index].imageAvatar),
                                        ),
                                      const Padding(padding: EdgeInsets.all(12)),
                                      Text(call.users[index].userName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  )
                                ],
                              )),
                          onTap: () async {

                          },
                        ),
                      );
                    },
                  )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(onPressed: ()async{
                          if(!connect)
                          {
                          await player.stop();
                           await voiceSpeak();
                          }
                          else
                          {
                          String res =  await config.server.callApi.exitCall(call.id);
                          if(res=='succes')
                          {
   Navigator.pop(context);
                          }
                        
                          }
                        }, icon:  Icon(Icons.phone, color:  connect? Colors.redAccent: Colors.lightGreen),
                          color: config.accentColor, iconSize: 30, style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white60), ), ),
                        IconButton(onPressed: ()async{
                          

setState(() {
  voice = !voice;
});


                        }, icon:  Icon(voice?Icons.mic_none_rounded:Icons.mic_off_sharp, color:  voice? Colors.lightGreen: Colors.redAccent),
                          color: config.accentColor, iconSize: 30, style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white60), ), ),

                      ],),
                  ),
                  Center(
                    child: InkWell(onTapUp: (_){setState(() {
                      voice =false;
                    }); }, onTapDown: (_){setState(() {
                      voice = true;
                    }); }, child: Container( decoration:BoxDecoration(
                      color: voice?Colors.green:Colors.redAccent,
    borderRadius: BorderRadius.circular(4),
    ),width: MediaQuery.of(context).size.width*0.9, height: MediaQuery.of(context).size.height*0.1,
                      child: const Icon(Icons.mic, color: Colors.white70, size: 50,),), ),
                  )

                ],
              ),)]);
  }


}


