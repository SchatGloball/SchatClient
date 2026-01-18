import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:schat2/AllSocial/commentsScreen.dart';
import 'package:schat2/DataClasses/Post.dart';
import 'package:schat2/eventStore.dart';

import '../MessageService/audioPlayer.dart';
import '../MessageService/videoPlayer.dart';
import '../MessageService/webPreview.dart';
import '../downloadFile.dart';
import '../generated/social.pb.dart';
import '../imageViewer.dart';
import '../user/userScreen.dart';
import 'UserListScreen.dart';

class PostWidget extends StatefulWidget {
  late PostData post;
  PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidget(post: post);
}

class _PostWidget extends State<PostWidget> {
  late PostData post;

  _PostWidget({required this.post});



  @override
  void initState() {
    super.initState();
  }

  updateData()async
  {
    PostDto p = await config.server.socialApi.getOnePost(post.id);
    setState(() {
      post = PostData(p);
    });
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
              Text(post.body, style: Theme.of(context).textTheme.titleMedium),
              GridView.builder(
                itemCount: post.imageContent.length,
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
                                  image: post.imageContent[indexTwo])));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: AspectRatio(
                        aspectRatio: 1 / 1, // задаем соотношение сторон 1:1
                        child: Image.network(
                          post.imageContent[indexTwo], // ваш URL изображения
                          fit: BoxFit.cover, // заполняем пространство виджета
                        ),
                      ),
                    ),
                  );
                },
              ),
              GridView.builder(
                itemCount: post.videoContent.length,
                itemBuilder: (context, indexTwo) {
                  return VideoPage(urlVideo: post.videoContent[indexTwo]);
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
                itemCount: post.audioContent.length,
                itemBuilder: (context, indexTwo) {
                  return AudioPage(urlAudio: post.audioContent[indexTwo]);
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // запрещает прокрутку списка
              ),
              GridView.builder(
                itemCount: post.documentContent.length,
                itemBuilder: (context, indexTwo) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          'file.${post.documentContent[indexTwo].split('?X').first.split('.').last}',
                          style: Theme.of(context).textTheme.titleLarge),
                      IconButton(
                          onPressed: ()async {

                            await downloadFile(
  fileExtension: post.documentContent[indexTwo]
                                    .split('?X')
                                    .first
                                    .split('.')
                                    .last,
  url: post.documentContent[indexTwo],
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
                itemCount: post.linksInBody.length,
                itemBuilder: (context, indexTwo) {
                  return WebPreview(link: post.linksInBody[indexTwo]);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // количество виджетов в ряду
                  childAspectRatio: 2 / 1,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // запрещает прокрутку списка
              ),
              if(post.stickerContent != 0)
            Center(
        child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3 - kToolbarHeight,
        child: Lottie.asset('assets/${post.stickerContent}.json'),
      )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [InkWell(child: Text(post.authorName, style: Theme.of(context).textTheme.titleSmall), onTap: ()async
                {
                  if(post.authorName==config.server.userGlobal.userName)
                    {return;}
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => UserPage(userName: post.authorName,)));},),
                  Text('  ${post.datePost}', style: Theme.of(context).textTheme.titleSmall)],),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(child: Row(children: [IconButton(onPressed: ()async{
                     await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => CommentsPage(post: post)));
                     setState(() {
                       updateData();
                     });
                  }, icon:  Icon(Icons.comment_rounded, color: config.accentColor,)),
                    Text('${post.comments.length}', style: Theme.of(context).textTheme.titleSmall), ],),),
                  SizedBox(child: Row(children: [
                    IconButton(
                        onLongPress: ()async{
                          await  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => UserListPage(userList: post.likes)));
                        },
                        onPressed: ()async{
                          ResponseDto res = await config.server.socialApi.likePost(PostDto(id: post.id));
                          if(res.success&&post.likes.contains(config.server.userGlobal.userName))
                          {
                            setState(() {
                              post.likes.remove(config.server.userGlobal.userName);
                            });
                            return;
                          }
                          if(res.success&&!post.likes.contains(config.server.userGlobal.userName))
                          {
                            setState(() {
                              post.likes.add(config.server.userGlobal.userName);
                            });
                          }

                    }, icon: Icon(Icons.favorite_outlined, color: config.accentColor,)), Text('${post.likes.length}', style: Theme.of(context).textTheme.titleSmall),],),),
                  if(post.authorId == config.server.userGlobal.id)
                    SizedBox(child: IconButton(onPressed: (){
                    }, icon: Icon(Icons.delete_forever, color: config.accentColor,)),),
                ],),
   ],
          ),
        ),
      );
  }
}