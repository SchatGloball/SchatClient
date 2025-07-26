import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../eventStore.dart';






class AudioPage extends StatefulWidget {
  late String urlAudio;
  AudioPage({super.key, required this.urlAudio});
  @override
  State<AudioPage> createState() => _AudioPage(urlAudio: urlAudio);
}
class _AudioPage extends State<AudioPage> with TickerProviderStateMixin {
  late String urlAudio;
  _AudioPage({required this.urlAudio});
  bool playMessage = false;
  int contentLength  = 0;
  String recordingDuration = '';
  late AnimationController controller;
  double valueController = 0.0;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 1),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    player.player.stop();
  }



  timerRecording(int seconds)
  {
    if(!playMessage)
    {
      return;
    }

    String s = '';
    String m = '';
    seconds -=1;
    int minutes = 0;
    if(seconds>59)
    {
      minutes = seconds ~/60;
    }
    if(seconds %60 >9)
      {
        s = '${seconds %60}';
      }
    else
      {
        s = '0${seconds %60}';
      }
    if(minutes >9)
    {
      m = '${minutes %60}';
    }
    else
    {
      m = '0${minutes %60}';
    }

    setState(() {
      recordingDuration = '$m:$s';
    });
    return Future.delayed(const Duration(seconds: 1), () => timerRecording(seconds));
  }

  @override
  Widget build(BuildContext context) {
    return
      LayoutBuilder(
        builder: (context, constraints) {
          final parentWidth = constraints.maxWidth;

          return SizedBox(
            width: parentWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text('${urlAudio.split('.separated.').last.split('.').first} \n \n', style: Theme.of(context).textTheme.titleSmall,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: parentWidth * 0.67,
                      height: MediaQuery.of(context).size.height * 0.02,
                      child:
                      LinearProgressIndicator(
                        valueColor:  AlwaysStoppedAnimation<Color>(config.accentColor,),
                        value: controller.value,
                      ),),
                    IconButton(onPressed: ()async{
                      if(!playMessage)
                      {
                        //считаем размер файла
                        if(config.isWeb)
                        {
                          http.Response response = await http.get(Uri.parse(urlAudio));
                          contentLength = response.contentLength!;
                        }
                        else
                        {
                          final client = HttpClient();
                          final request = await client.getUrl(Uri.parse(urlAudio));
                          final response = await request.close();
                          contentLength = response.contentLength;
                          client.close();
                        }


                        setState(() {
                          controller =  AnimationController(
                            vsync: this, // the SingleTickerProviderStateMixin
                            duration: Duration(seconds: contentLength ~/ 80000),
                          );
                          playMessage = true;
                          timerRecording(contentLength ~/ 80000 +1);
                          controller.forward();
                        });
                        player.playWebSound(urlAudio);
                        //await player.play(UrlSource(urlAudio, mimeType: 'audio/wav'));
                        player.player.onPlayerComplete.listen((event) {
                          setState(() {
                            playMessage = false;
                            controller.stop();
                            recordingDuration = '';
                          });
                        });
                      }
                      else
                      {
                        player.player.stop();
                        setState(() {
                          playMessage = false;
                          controller = AnimationController(
                            vsync: this, // the SingleTickerProviderStateMixin
                            duration: const Duration(seconds: 1),
                          );
                          controller.stop();
                          recordingDuration = '';
                        });
                      }
                    }, icon: playMessage?  Icon(Icons.stop, size: 50, color: config.accentColor,): Icon(Icons.play_arrow, size: 50, color: config.accentColor))],
                ),
                Text(
                  recordingDuration, // Ваш текст
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, // Жирный шрифт
                  ),
                ),
              ],
            ),
          );
        },
      );
  }
}