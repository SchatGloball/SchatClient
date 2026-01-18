import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:schat2/MessageService/reactionWidget.dart';
import 'package:schat2/MessageService/videoPlayer.dart';
import 'package:schat2/MessageService/webPreview.dart';
import 'package:schat2/generated/chats.pb.dart';

import '../DataClasses/chatData.dart';
import '../downloadFile.dart';
import '../eventStore.dart';
import '../imageViewer.dart';
import '../localization/localization.dart';
import 'audioPlayer.dart';

class MessageOne extends StatelessWidget {
  MessageOne({super.key, required this.message});
  late Message message;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: selectedMessages.contains(message) ? config.accentColor: null,
        padding: const EdgeInsets.all(2),
          child: Row(
          mainAxisAlignment: message.authorId == config.server.userGlobal.id
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(7)),
           // IconButton(onPressed: (){}, icon: Icon(Icons.info), iconSize: 19,) ,
            Text('${message.dateMessage} ${message.authorName}',
                style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
        )
        ,
        if(message.forwarded)
          Container(
            color: Colors.white10,
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.all(7)),
                Text('${Localization.localizationData[config.language]
                ['messageScreen']['forwarded']} \n${message.originalDate} ${message.originalAuthor}',
                    style: Theme.of(context).textTheme.titleSmall)
              ],
            ),
          )
        ,
        Row(
          mainAxisAlignment: message.authorId == config.server.userGlobal.id
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(7)),
            Flexible(
              child: SelectionArea(
                  child: Text(message.body,
                      style: Theme.of(context).textTheme.titleLarge)),
            ),
          ],
        ),
        ListView.builder(
          itemCount: message.imageContent.length,
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 1, // количество виджетов в ряду
          //   childAspectRatio: 3 / 1,
          // ),
          shrinkWrap:
          true, // позволяет списку занимать только необходимое пространство
          physics:
          const NeverScrollableScrollPhysics(), // запрещает прокрутку списка
          itemBuilder: (BuildContext context, int indexTwo) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ImageViewerPage(
                            image: message.imageContent[indexTwo])));
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                child: AspectRatio(
                  aspectRatio: 2, // задаем соотношение сторон 1:1
                  child: Image.network(
                    message.imageContent[indexTwo], // ваш URL изображения
                    fit: BoxFit.scaleDown, // заполняем пространство виджета
                  ),
                ),
              ),
            );
          },
        ),
        GridView.builder(
          itemCount: message.videoContent.length,
          itemBuilder: (context, indexTwo) {
            return VideoPage(urlVideo: message.videoContent[indexTwo]);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // количество виджетов в ряду
            childAspectRatio: 1 / 1,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // запрещает прокрутку списка
        ),
        ListView.builder(
          itemCount: message.audioContent.length,
          itemBuilder: (context, indexTwo) {
            return AudioPage(urlAudio: message.audioContent[indexTwo]);
          },
          
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // запрещает прокрутку списка
        ),
        ListView.builder(
          itemCount: message.documentContent.length,
          itemBuilder: (context, indexTwo) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    'file.${message.documentContent[indexTwo].split('?X').first.split('.').last}',
                    style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                    onPressed: () async{
                      await downloadFile(
  fileExtension: message.documentContent[indexTwo]
                              .split('?X')
                              .first
                              .split('.')
                              .last,
  url: message.documentContent[indexTwo],
);
                      
                    },
                    icon: const Icon(
                      Icons.save_alt,
                      size: 50,
                    ))
              ],
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // запрещает прокрутку списка
        ),
        ListView.builder(
          itemCount: message.linksInBody.length,
          itemBuilder: (context, indexTwo) {
            return WebPreview(link: message.linksInBody[indexTwo]);
          },
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 1, // количество виджетов в ряду
          //   childAspectRatio: 2 / 1,
          // ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // запрещает прокрутку списка
        ),
        if (message.stickerContent != 0)
          Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2 - kToolbarHeight,
                child: Lottie.asset('assets/${message.stickerContent}.json'),
              )),
        if (message.delivered && message.authorId == config.server.userGlobal.id)
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check,
                color: Colors.white70,
              )
            ],
          ),
ListView.builder(
          itemCount: message.buttons.length,
          itemBuilder: (context, indexTwo) {
            return 
            Container(
              padding: EdgeInsets.all(3),
              child: ElevatedButton(onPressed: ()async{
             await config.server.chatApi.sendReaction(ReactionMessage(ReactionMessageDto(authorId: config.server.userGlobal.id, body:  message.buttons[indexTwo], authorName: config.server.userGlobal.userName, messageId: message.id, dateReaction: DateTime.now().toString(), stickerContent: 0)));
            }, child: Text(message.buttons[indexTwo])),)
            ;
            
          },
          
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        
        ),

        if(message.reactions.isNotEmpty)
          ReactionWidget(message: message)
      ],
    );
  }
}
