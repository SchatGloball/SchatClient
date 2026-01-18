import 'package:flutter/material.dart';
import 'package:schat2/AllSocial/createPost.dart';
import 'package:schat2/generated/social.pb.dart';

import '../AllSocial/postWidget.dart';
import '../DataClasses/Post.dart';
import '../DataClasses/file.dart';
import '../allWidgets/infoDialog.dart';
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
    List<PostDto> p = await config.server.socialApi.getUserPosts(config.server.userGlobal.id, offset);
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
       Map res = await config.server.userApi.uploadAvatar(files.last);
      if (res.keys.contains('Error')) {
        infoDialog(context, res['Error'].toString());
      } else {
        setState(() {
          config.server.userGlobal.imageAvatar = res['link'].message;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return
     LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
        double size = screenSize.width > screenSize.height?config.maxHeightWidescreen:0.95;
        return
        Stack(children: [
      Image.asset(
        'assets/${config.backgroundAsset}',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                pickFile();
              },
              icon: const Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                
                config.server.setTokens('', '');
                allChats.clear();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>  InitialApp( checkLocalPass: false,),
                  ),
                );
              },
              icon: const Icon(
                Icons.exit_to_app,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: 
        Center(
          child: SizedBox(
             width: MediaQuery.of(context).size.width * size,
            child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.29 - kToolbarHeight,
              padding: const EdgeInsets.all(10),
              color: Colors.black26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (config.server.userGlobal.imageAvatar == '')
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
                  if (config.server.userGlobal.imageAvatar != '')
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ImageViewerPage(
                                      image: config.server.userGlobal.imageAvatar,
                                    )));
                      },
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(config.server.userGlobal.imageAvatar),
                      ),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Text(config.server.userGlobal.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                  ],)

                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
    itemCount: userPosts.length,
    itemBuilder: (context, index) {
      return PostWidget(post: userPosts[index],);
    },
              ),
            )
          ],
        ),
          ),
        )
        
        ,
        floatingActionButton: FloatingActionButton(
          
          onPressed: () async {
       await  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CreatePostPage(post: PostData(PostDto(id: 0, body: '', authorId: config.server.userGlobal.id, channelId: -1, authorName: config.server.userGlobal.userName, data: [], likes: [], content: [], comments: [], datePost: '2025-06-13 15:31:56.050045', tags: [], topik: 'general', stickerContent: 0)),)));
              getUserPosts(userPosts.length);

          },
          child: Icon(
            Icons.add_box_outlined,
          ),
        ),
      )
    ]);
        });
     
  }
}
