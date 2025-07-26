import 'package:flutter/material.dart';
import '../AllSocial/postWidget.dart';
import '../DataClasses/Post.dart';
import '../DataClasses/UserData.dart';
import '../MessageService/message.dart';
import '../eventStore.dart';
import '../generated/call.pb.dart';
import '../generated/social.pb.dart';
import '../imageViewer.dart';
import '../СallService/callScreen.dart';



class UserPage extends StatefulWidget
{
  final String userName;
  const UserPage({required this.userName, super.key});

  @override
  State<UserPage> createState() => _UserPage(userName: userName);
}

class _UserPage extends State<UserPage> {

  final String userName;

  _UserPage({required this.userName});

  User user = User(0, 'deleted', '');
  @override
  void initState() {
    findUser();
    super.initState();

  }

findUser()async
{
  Map res = await userApi.searchUser(userName);
  if (res.keys.first != 'Error' && res['users'].isNotEmpty) {
    for(var userFind in res['users'])
      {
        if(userFind.username == userName)
          {
            setState(() {
              user = User(userFind.id, userFind.username,
                  userFind.imageAvatar);
            });
          }
      }
  }
  getUserPosts(userPosts.length);
}
  List<PostData> userPosts = [];

  getUserPosts(int offset)async
  {
    List<PostDto> p = await socialApi.getUserPosts(user.id, offset);
    for(PostDto post in p)
    {
      userPosts.add(PostData(post));
    }
    setState(() {

    });
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
        appBar:
      AppBar(
                    backgroundColor: config.accentColor,
                    leading: BackButton(
                        onPressed: (){
                          Navigator.of(context).pop();}
                    ),
                    automaticallyImplyLeading: false,
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
                  if (user.imageAvatar == '')
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
                  if (user.imageAvatar != '')
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ImageViewerPage(
                                      image: user.imageAvatar,
                                    )));
                      },
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(user.imageAvatar),
                      ),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Text(user.userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          IconButton(onPressed: ()async{
                                            if(user.dialogToUser)
                                              {
                                                Navigator.pop(context);
                                                if(!config.widescreen)
                                                  {
                                                    Navigator.pop(context);
                                                  }
                                                for (int i =0; i < allChats.length; i++) {
                                                  if(allChats[i].members.length==2&&allChats[i].members.contains(userName) && !config.widescreen)
                                                  {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext context) => MessagePage(chat: allChats[i],)));
                                                  }
                                                }
                                              }
                                            else
                                              {
                                                await chatApi.createChat('', [{'userName': userGlobal.userName, 'imageAvatar': userGlobal.imageAvatar}, {'userName': user.userName, 'imageAvatar': user.imageAvatar}]);
                                                setState(() {
                                                  user.dialogToUser;
                                                });
                                              }
                                          }, icon: const Icon(Icons.message), color: config.accentColor, iconSize: 30, style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white60),),),
                                        IconButton(onPressed: ()async{
                                         final Map call = await callApi.createCall([UserDto(username: user.userName, imageAvatar: user.imageAvatar)], false);
                                          activeCall = call['status'];
                                          }, icon: const Icon(Icons.phone), color: config.accentColor, iconSize: 30, style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white60),),)
                                      ],)
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
      )
    ]);
  }

}
