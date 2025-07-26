import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:schat2/AllSocial/createPost.dart';
import 'package:schat2/generated/social.pb.dart';

import '../AllSocial/postWidget.dart';
import '../DataClasses/Post.dart';
import '../DataClasses/file.dart';
import '../allWidgets/infoDialog.dart';
import '../appTheme.dart';
import '../eventStore.dart';
import '../imageViewer.dart';
import '../main.dart';

class UserGeneralPage extends StatefulWidget {
  UserGeneralPage({super.key});

  @override
  State<UserGeneralPage> createState() => _UserGeneralPage();
}

class _UserGeneralPage extends State<UserGeneralPage> {
  @override
  void initState() {
    super.initState();
    getUserPosts(0);
  }



  List<PostData> userPosts = [];

  getUserPosts(int offset)async
  {
    List<PostDto> p = await socialApi.getUserPosts(userGlobal.id, offset);
    for(PostDto post in p)
      {
        userPosts.add(PostData(post));
      }
   setState(() {

   });
  }


  pickFile() async {
    List<FileData> files = await pickFiles();
    if(files.isEmpty)
      {return;}
       Map res = await userApi.uploadAvatar(files.last);
      if (res.keys.contains('Error')) {
        infoDialog(context, res['Error'].toString());
      } else {
        setState(() {
          userGlobal.imageAvatar = res['link'].message;
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
          backgroundColor: config.accentColor,
          leading: BackButton(
              color: Colors.white54,
              onPressed: () {
                Navigator.of(context).pop();
              }),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                pickFile();
              },
              icon: const Icon(
                Icons.add_a_photo_outlined,
                color: Colors.white54,
              ),
            ),
            IconButton(
              onPressed: () async {
                userGlobal.accessToken = '';
                userGlobal.refreshToken = '';
                userGlobal.clearTokens();
                await eventStream.cancel();
                await chatApi.updateEvent.cancel();
                allChats.clear();
                listenServerEvent.cancel();
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => const InitialApp(),
                //   ),
                // );

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MaterialApp(
                              home: InitialApp(checkLocalPass: false,),
                              darkTheme: darkTheme,
                              themeMode: ThemeMode.dark,
                            )),
                    (Route<dynamic> route) => false);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white54,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.29 - kToolbarHeight,
              padding: const EdgeInsets.all(10),
              color: Colors.black26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (userGlobal.imageAvatar == '')
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        color: config.accentColor,
                        Icons.person,
                        size: 180,
                      ),
                     // width: MediaQuery.of(context).size.width / 1.5,
                    //  height: MediaQuery.of(context).size.height / 5,
                    ),
                  if (userGlobal.imageAvatar != '')
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ImageViewerPage(
                                      image: userGlobal.imageAvatar,
                                    )));
                      },
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(userGlobal.imageAvatar),
                      ),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Text(userGlobal.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                  ],)

                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7 - kToolbarHeight,
              child: ListView.builder(
    itemCount: userPosts.length,
    itemBuilder: (context, index) {
      return PostWidget(post: userPosts[index],);
    },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black54,
          onPressed: () async {
       await  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CreatePostPage(post: PostData(PostDto(id: 0, body: '', authorId: userGlobal.id, channelId: -1, authorName: userGlobal.userName, data: [], likes: [], content: [], comments: [], datePost: '2025-06-13 15:31:56.050045', tags: [], topik: 'general', stickerContent: 0)),)));

           //   await Future.delayed(const Duration(seconds: 3));
       //userPosts.clear();
              getUserPosts(userPosts.length);

          },
          child: Icon(
            Icons.add_box_outlined,
            color: config.accentColor,
          ),
        ),
      )
    ]);
  }
}
