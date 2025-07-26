import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:mp_audio_stream/mp_audio_stream.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';



import '../DataClasses/callData.dart';
import '../eventStore.dart';
import '../generated/call.pb.dart';
import '../main.dart';



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

  final audioStream = getAudioStream();
  // Получаем Stream из контроллера
  final record = AudioRecorder();

  @override
  void initState() {
    audioStream.init();
    findUser();
    super.initState();
    if(activeCall==call.id)
    {
      voiceSpeak();
    }
  }
bool voice = false;

  @override
  void dispose() {
    controller.onCancel;
    audioStream.uninit();
    super.dispose();
  }



  // Stream<RequestDto> startVoice() async* {
  //   if (await record.hasPermission()) {
  //     Stream<RequestDto> streamUpdate = controller.stream;
  //     Stream<Uint8List> streamAudio = await record.startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits, numChannels: 1, bitRate: sampleRate));
  //    streamAudio.listen((update) {
  //      controller.add(RequestDto(room: call.id, callData: CallDto(soundData: update, videoData: [])));
  //     },);
  //     yield* streamUpdate;
  //   }
  // }
Uint8List u = Uint8List(11264);
  Stream<RequestDto> startVoice() async* {
    if (await record.hasPermission()) {
      final Stream<Uint8List> stream = await record.startStream(
          const RecordConfig(
              encoder: AudioEncoder.pcm16bits, numChannels: 1, bitRate: 44100));
      stream.listen((item) {

        u=item;
        print(item.length);
        if(voice)
        {
          controller.add(RequestDto(room: call.id, callData: CallDto(soundData: item, videoData: [])));
        }
        else
        {
          controller.add(RequestDto(room: call.id, callData: CallDto(soundData: [], videoData: [])));}
      });
      Stream<RequestDto> streamUpdate = controller.stream;

      yield* streamUpdate;
    }
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

  Float32List uint8ListToFloat32ListAudio(Uint8List uint8List, {int sampleWidth = 16, bool isSigned = false}) {
    if (uint8List.length % (sampleWidth ~/ 8) != 0) {
      throw ArgumentError('Uint8List length must be a multiple of sampleWidth.');
    }

    final numSamples = uint8List.length ~/ (sampleWidth ~/ 8);
    final float32List = Float32List(numSamples);
    final byteData = ByteData.view(uint8List.buffer);

    for (int i = 0; i < numSamples; i++) {
      int sampleValue;
      switch (sampleWidth) {
        case 8:
          sampleValue = byteData.getInt8(i);
          break;
        case 16:
          sampleValue = byteData.getInt16(i * 2, Endian.little); // или Endian.big
          break;
      // Добавьте другие случаи для 24-битных и т.д.
        default:
          throw ArgumentError('Unsupported sample width: $sampleWidth');
      }

      // Нормализация к диапазону [-1.0, 1.0]
      double normalizedValue;
      if (!isSigned) {
        normalizedValue = 2 * (sampleValue / (pow(2, sampleWidth) - 1)) - 1;
      } else {
        normalizedValue = sampleValue / pow(2, sampleWidth - 1); // Остаётся без изменений для signed данных
      }

      float32List[i] = normalizedValue;
    }
    return float32List;
  }

  voiceSpeak()async
  {
    setState(() {
      connect = true;
    });

    Stream<RequestDto> n = startVoice();
    Stream<UpdateDTO> voiceStream = callApi.enterToRoom(n);

    voiceStream.listen((update) async {
      final float32List = uint8ListToFloat32ListAudio(u, sampleWidth: 16);
   audioStream.push(float32List);
 //   return;


    // List<double> b = [];
    // for(int i in update.callData.soundData)
    //   {
    //     b.add(double.parse(i.toString()));
    //   }
    //   audioStream.push(Float32List.fromList(b));
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
                           await voiceSpeak();
                          }
                          else
                          {
                            Navigator.pop(context);
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


