import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:schat2/AllSocial/UserListScreen.dart';
import 'package:schat2/eventStore.dart';
import 'package:schat2/generated/social.pb.dart';

import '../DataClasses/Comment.dart';
import '../MessageService/audioPlayer.dart';
import '../MessageService/videoPlayer.dart';
import '../MessageService/webPreview.dart';
import '../downloadFile.dart';
import '../imageViewer.dart';

class CommentWidget extends StatefulWidget {
  late CommentData comment;
  CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidget(comment: comment);
}

class _CommentWidget extends State<CommentWidget> {
  late CommentData comment;

  _CommentWidget({required this.comment});



  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.all(5),
        child: Container(
          color: Colors.black26,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(comment.body, style: Theme.of(context).textTheme.titleMedium),

              GridView.builder(
                itemCount: comment.imageContent.length,
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
                                  image: comment.imageContent[indexTwo])));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: AspectRatio(
                        aspectRatio: 1 / 1, // задаем соотношение сторон 1:1
                        child: Image.network(
                          comment.imageContent[indexTwo], // ваш URL изображения
                          fit: BoxFit.cover, // заполняем пространство виджета
                        ),
                      ),
                    ),
                  );
                },
              ),
              GridView.builder(
                itemCount: comment.videoContent.length,
                itemBuilder: (context, indexTwo) {
                  return VideoPage(urlVideo: comment.videoContent[indexTwo]);
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
                itemCount: comment.audioContent.length,
                itemBuilder: (context, indexTwo) {
                  return AudioPage(urlAudio: comment.audioContent[indexTwo]);
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
                itemCount: comment.documentContent.length,
                itemBuilder: (context, indexTwo) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          'file.${comment.documentContent[indexTwo].split('?X').first.split('.').last}',
                          style: Theme.of(context).textTheme.titleLarge),
                      IconButton(
                          onPressed: ()async {
                             await downloadFile(
  fileExtension: comment.documentContent[indexTwo]
                                    .split('?X')
                                    .first
                                    .split('.')
                                    .last,
  url:  comment.documentContent[indexTwo],
);
                            
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
                itemCount: comment.linksInBody.length,
                itemBuilder: (context, indexTwo) {
                  return WebPreview(link: comment.linksInBody[indexTwo]);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // количество виджетов в ряду
                  childAspectRatio: 2 / 1,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // запрещает прокрутку списка
              ),
              if(comment.stickerContent != 0)
                Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3 - kToolbarHeight,
                      child: Lottie.asset('assets/${comment.stickerContent}.json'),
                    )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text(comment.authorName, style: Theme.of(context).textTheme.titleSmall), const Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 5)), Text(comment.dateComment, style: Theme.of(context).textTheme.titleSmall)],),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(child: Row(children: [IconButton(
                      onLongPress: ()async{
                        await  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => UserListPage(userList: comment.likes)));
                      },
                      onPressed: () async{
                    ResponseDto res = await config.server.socialApi.likeComment(CommentDto(id: comment.id));
                    if(res.success&&comment.likes.contains(config.server.userGlobal.userName))
                      {
                        setState(() {
                          comment.likes.remove(config.server.userGlobal.userName);
                        });
                        return;
                      }
                    if(res.success&&!comment.likes.contains(config.server.userGlobal.userName))
                    {
                      setState(() {
                        comment.likes.add(config.server.userGlobal.userName);
                      });
                    }
                  }, icon: Icon(Icons.favorite_rounded)), Text('${comment.likes.length}', style: Theme.of(context).textTheme.titleSmall),],),),
                  if(comment.authorId == config.server.userGlobal.id)
                    SizedBox(child: IconButton(onPressed: (){
                    }, icon: Icon(Icons.delete_forever)),),
                ],),
            ],
          ),
        ),
      );
  }
}