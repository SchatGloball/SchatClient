import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:schat2/AllSocial/commentWidget.dart';
import 'package:schat2/DataClasses/Comment.dart';
import 'package:schat2/MessageService/reactionWidget.dart';
import 'package:schat2/MessageService/videoPlayer.dart';
import 'package:schat2/MessageService/webPreview.dart';
import 'package:schat2/generated/social.pb.dart';
import 'package:uuid/uuid.dart';
import '../DataClasses/Post.dart';
import '../DataClasses/chatData.dart';
import '../DataClasses/file.dart';
import '../MessageService/audioPlayer.dart';
import '../MessageService/audioRecorder.dart';
import '../allWidgets/acceptDialog.dart';
import '../allWidgets/infoDialog.dart';
import '../downloadFile.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart' hide ResponseDto;
import '../imageViewer.dart';
import '../localization/localization.dart';
import '../user/userScreen.dart';


class CommentsPage extends StatefulWidget {
  late PostData post;
  CommentsPage({super.key, required this.post});

  @override
  State<CommentsPage> createState() => _CommentsPage(post: post);
}

class _CommentsPage extends State<CommentsPage> {
  late PostData post;
  String body = '';
  bool replyMessage = false;

  bool stickerPick = false;
  var uuid = const Uuid();
  List<FileData> filesPick = [];

  _CommentsPage({required this.post});

  ScrollController scrollController = ScrollController();
  final fieldText = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPost();
  }


  initPost()async
  {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

  }

  @override
  void dispose() {
    fieldText.dispose();
    super.dispose();
  }



  pickFile() async {
    filesPick = await pickFiles();
    setState(() {});
  }


  sendComment() async {
    ResponseDto res = await config.server.socialApi.createComment(CommentDto(id: 0, body: body, stickerContent: 0, authorId: config.server.userGlobal.id, authorName: config.server.userGlobal.userName, postId: post.id, likes: [], data: []), filesPick);
    if(res.success)
      {
        PostDto p = await  config.server.socialApi.getOnePost(post.id);
        setState(() {
          post = PostData(p);
          initPost();
        });

      }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/${config.backgroundAsset}',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        
        appBar: AppBar(
          
          leading: BackButton(onPressed: () {
            Navigator.of(context).pop();
          }),
          automaticallyImplyLeading: false,
          title: Text('comments', style: Theme.of(context).textTheme.titleLarge,),
        ),
        body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child:
                    ListView(
                      children: [Container(
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
                                          onPressed: () async{

                                            await downloadFile(
  fileExtension: post.documentContent[indexTwo]
                                                    .split('?X')
                                                    .first
                                                    .split('.')
                                                    .last,
  url:  post.documentContent[indexTwo],
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
                                children: [Text(post.datePost, style: Theme.of(context).textTheme.titleSmall)],),
                            ],
                          ),
                        ),
                      )],
                    ),),


                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: post.comments.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return CommentWidget(comment: post.comments[index]);
                      },
                    ),
                  ),
                  if (!recordAudio && !stickerPick)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.16 -
                          kToolbarHeight,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.height * 0.15 -
                                    kToolbarHeight,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: InkWell(
                                  onLongPress: () {
                                    setState(() {
                                      stickerPick = true;
                                    });
                                  },
                                  onTap: () {
                                    if (filesPick.isNotEmpty) {
                                      setState(() {
                                        filesPick.clear();
                                      });
                                      return;
                                    }
                                    pickFile();
                                  },
                                  child: filesPick.isEmpty
                                      ? Icon(Icons.add_a_photo_outlined,
                                       size: 40)
                                      : Icon(Icons.delete_forever,
                                       size: 40),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 6),
                            height: MediaQuery.of(context).size.height * 0.15 -
                                kToolbarHeight,
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  style: Theme.of(context).textTheme.titleLarge,
                                  cursorColor: config.accentColor,
                                  controller: fieldText,
                                  minLines: 1,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 2,
                                  onChanged: (String value) {
                                    body = value;
                                  },
                                )
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          Container(
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.height * 0.15 -
                                kToolbarHeight,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: InkWell(
                              onTap: () async {
 await sendComment();
                                fieldText.clear();
                              },
                              onLongPress: () async {
                                setState(() {
                                  recordAudio = true;
                                });
                              },
                              child: Icon(
                                Icons.send,
                                size: 40,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  // if (recordAudio)
                  //   Container(
                  //     height: MediaQuery.of(context).size.height * 0.16 -
                  //         kToolbarHeight,
                  //     width: MediaQuery.of(context).size.width * 0.95,
                  //     decoration: BoxDecoration(
                  //       color: Colors.black54,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: AudioRecorderPage(chatId: chat.id),
                  //   ),
                  if (stickerPick)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.16 -
                          kToolbarHeight,
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: MediaQuery.of(context).size.height * 0.16,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  stickerPick = false;
                                });
                              },
                              child: Icon(
                                Icons.highlight_remove,
                                color: config.accentColor,
                                size: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: MediaQuery.of(context).size.height * 0.16,
                            child: InkWell(
                              onTap: () {
                                if (selectStickerPack + 1 <
                                    config.stickersAssets.length) {
                                  setState(() {
                                    ++selectStickerPack;
                                  });
                                } else {
                                  setState(() {
                                    selectStickerPack = 0;
                                  });
                                }
                              },
                              child: Lottie.asset(
                                  'assets/${config.stickersAssets[selectStickerPack].first}.json'),
                            ),
                          ),
                          SizedBox(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.78,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                config.stickersAssets[selectStickerPack].length,
                                itemBuilder: (context, indexTwo) {
                                  return InkWell(
                                    onTap: () async {

                                    },
                                    child: Lottie.asset(
                                        'assets/${config.stickersAssets[selectStickerPack][indexTwo]}.json'),
                                  );
                                },
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, // количество виджетов в ряду
                                  childAspectRatio: 5 / 5,
                                ),
                                // запрещает прокрутку списка
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ]),
      )
    ]);
  }
}

