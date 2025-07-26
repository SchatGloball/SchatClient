import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:schat2/MessageService/reactionWidget.dart';
import 'package:schat2/MessageService/videoPlayer.dart';
import 'package:schat2/MessageService/webPreview.dart';

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
        Row(
          mainAxisAlignment: message.authorId == userGlobal.id
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(7)),
            Text('${message.dateMessage} ${message.authorName}',
                style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
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
          mainAxisAlignment: message.authorId == userGlobal.id
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
        GridView.builder(
          itemCount: message.imageContent.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // количество виджетов в ряду
            childAspectRatio: 1 / 1,
          ),
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
                  aspectRatio: 1 / 1, // задаем соотношение сторон 1:1
                  child: Image.network(
                    message.imageContent[indexTwo], // ваш URL изображения
                    fit: BoxFit.cover, // заполняем пространство виджета
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
        GridView.builder(
          itemCount: message.audioContent.length,
          itemBuilder: (context, indexTwo) {
            return AudioPage(urlAudio: message.audioContent[indexTwo]);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // количество виджетов в ряду
            childAspectRatio: 5 / 1,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // запрещает прокрутку списка
        ),
        GridView.builder(
          itemCount: message.documentContent.length,
          itemBuilder: (context, indexTwo) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    'file.${message.documentContent[indexTwo].split('?X').first.split('.').last}',
                    style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                    onPressed: () {
                      downloadFile(
                          message.documentContent[indexTwo]
                              .split('?X')
                              .first
                              .split('.')
                              .last,
                          message.documentContent[indexTwo]);
                    },
                    icon: const Icon(
                      Icons.save_alt,
                      size: 50,
                    ))
              ],
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // количество виджетов в ряду
            childAspectRatio: 5 / 1,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // запрещает прокрутку списка
        ),
        GridView.builder(
          itemCount: message.linksInBody.length,
          itemBuilder: (context, indexTwo) {
            return WebPreview(link: message.linksInBody[indexTwo]);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // количество виджетов в ряду
            childAspectRatio: 2 / 1,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // запрещает прокрутку списка
        ),
        if (message.stickerContent != 0)
          Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3 - kToolbarHeight,
                child: Lottie.asset('assets/${message.stickerContent}.json'),
              )),
        if (message.delivered && message.authorId == userGlobal.id)
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check,
                color: Colors.white70,
              )
            ],
          ),
        if(message.reactions.isNotEmpty)
          ReactionWidget(message: message)
      ],
    );
  }
}
