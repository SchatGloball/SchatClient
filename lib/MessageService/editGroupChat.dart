import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../DataClasses/chatData.dart';
import '../DataClasses/file.dart';
import '../allWidgets/infoDialog.dart';
import '../env.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart';
import '../imageViewer.dart';
import '../localization/localization.dart';
import '../user/userScreen.dart';



class EditGroupPage extends StatefulWidget
{
  late Chat groupChat;
   EditGroupPage({super.key, required this.groupChat});

  @override
  State<EditGroupPage> createState() => _EditGroupPage(groupChat: groupChat);
}

class _EditGroupPage extends State<EditGroupPage> {
  late Chat groupChat;

  _EditGroupPage({required this.groupChat});
  @override
  void initState() {
    super.initState();
    nameChat.text = groupChat.name;
    chatName = groupChat.name;
  }

  List<String> addUsers = [];

  TextEditingController nameChat = TextEditingController();
  FileData addImage = FileData('', [], '');
  List findUsers = [];
  String chatName = '';

  searchUser(String memberName) async
  {
    findUsers.clear();
    Map res = await userApi.searchUser(memberName);
    if (res.keys.first == 'Error') {

    }
    else {
      for (var e in res['users']) {
        findUsers.add({'userName': e.username, 'imageAvatar': e.imageAvatar});
      }
    }
    setState(() {
      findUsers = findUsers;
    });
  }

  pickFile()async
  {
    List<FileData> files =  [];
    files = await pickFiles();
    if(files.isEmpty)
      {infoDialog(context, Localization.localizationData[config.language]['messageScreen']['fileType']);
      return;}
    addImage = files.last;
  }


  @override
  Widget build(BuildContext context) {
    return
      Stack(
          children: [
            Image.asset(
              'assets/${config.backgroundAsset}',
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              fit: BoxFit.cover,
            ),
            Scaffold(
                appBar: AppBar(
                  backgroundColor: config.accentColor,
                  leading: BackButton(
                      color: Colors.white54,
                      onPressed: (){
                        Navigator.of(context).pop();}
                  ),
                  automaticallyImplyLeading: false,
                ),
                backgroundColor: Colors.transparent,
                body:
    SingleChildScrollView(
    child:
    Column(
      children: [
        Text(Localization
            .localizationData[config.language]['editGroupScreen']['title'],
            style: Theme.of(context).textTheme.titleMedium
        ),

        TextField(
          controller: nameChat,
          onChanged: (String value) {
            setState(() {
              chatName = value;
            });
          },
          decoration: InputDecoration(
            labelText: Localization
                .localizationData[config.language]['editGroupScreen']['nameChat'],
            labelStyle: Theme.of(context).textTheme.titleLarge,
          ),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(Localization
            .localizationData[config.language]['createChatScreen']['members'] + '  (${groupChat.members.length})',
            style: Theme.of(context).textTheme.titleMedium),
        SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 3.5,
            child: ListView.builder(
              itemCount: groupChat.members.length,
              itemBuilder: (context, index) {
                return
                  Card(
                    color: config.accentColor,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => UserPage(userName: groupChat.members[index].toString(),)));
                          },
                          child: ListTile(
                            leading: addUsers.contains(groupChat.members[index])?IconButton(onPressed: (){
                              setState(() {
                                addUsers.remove(groupChat.members[index]);
                                groupChat.members.remove(groupChat.members[index]);
                              });
                            }, icon: const Icon(Icons.delete)):const Text(''),
                            title: Text(groupChat.members[index], style: Theme.of(context).textTheme.titleMedium,),
                          ),
                        ),
                      ],
                    ),
                  );
              },
            )
        ),


        Text(Localization
            .localizationData[config.language]['editGroupScreen']['findUsers'],
            style: Theme.of(context).textTheme.titleMedium),


        TextField(
          onChanged: (String value) {
            searchUser(value);
          },
          decoration: InputDecoration(
            labelText: Localization
                .localizationData[config.language]['editGroupScreen']['nameUser'],
            labelStyle: Theme.of(context).textTheme.titleLarge,
          ),
          style: Theme.of(context).textTheme.titleLarge,
        ),

        Column(children: [
          SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 3.5,
              child:
              ListView.builder(
                itemCount: findUsers.length,
                itemBuilder: (context, index) {
                  return
                    Card(
                      color: Colors.white70,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => UserPage(userName: findUsers[index]['userName'],)));
                            },
                            child: ListTile(
                              leading: Column(children: [
                                if(findUsers[index]['imageAvatar'] ==
                                    '')
                                  const Icon(Icons.person),
                                if(findUsers[index]['imageAvatar'] !=
                                    '')
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        findUsers[index]['imageAvatar']),
                                  )
                              ]),
                              title: Text(Localization
                                  .localizationData[config.language]['editGroupScreen']['userName'] +
                                  findUsers[index]['userName']),
                              subtitle: TextButton(
                                child: const Text('Add'),
                                onPressed: () {
                                  if(groupChat.members.contains(findUsers[index]['userName']))
                                  {return;}

                                  setState(() {
                                    addUsers.add(findUsers[index]['userName']);
                                    groupChat.members.add(
                                        findUsers[index]['userName']);
                                    findUsers.removeAt(index);
                                  });
                                },
                              ),
                            )

                            ,)

                        ],
                      ),
                    );
                },
              ))
        ],),
        Container(
          color: Colors.white54,
            width: MediaQuery
                .of(context)
                .size
                .width / 1.1,
            padding: const EdgeInsets.only(top: 8),
            child:
            Column(
    children: [
      Text(Localization
        .localizationData[config.language]['editGroupScreen']['groupImage'], style: Theme.of(context).textTheme.titleMedium),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if(groupChat.chatImage==''&&addImage.data.isEmpty)
            const Icon(Icons.people,  color: Colors.white, size: 30),
          if(addImage.data.isNotEmpty)
              IconButton(onPressed: (){
                setState(() {
                  addImage.data.clear();
                });
              }, icon: const Icon(Icons.delete_forever_sharp, color: Colors.red, size: 30,)),
          if(groupChat.chatImage!=''&&addImage.data.isEmpty)
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ImageViewerPage(image: groupChat.chatImage,)));
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(groupChat.chatImage),
              ),
            ), const Padding(padding: EdgeInsets.only(right: 10)), IconButton(onPressed: (){
            pickFile();
          }, icon: Icon(Icons.image_search_outlined, color: config.accentColor, size: 30, )),],
      )
    ],
    )
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2.3,
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(onPressed: () {
                for (var element in addUsers) {
                  groupChat.members.remove(element);
                }
                Navigator.pop(context);
              },
                child: Text(Localization
                    .localizationData[config.language]['editGroupScreen']['back'],),
              )),
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2.3,
                padding: const EdgeInsets.only(top: 8),
                child: ElevatedButton(onPressed:
                (groupChat.members.length >= 2||groupChat.members.length >= 3 && chatName != '') ?
                    () async {
                  List<MemberDto> m = [];
                  for (var element in groupChat.members) {m.add(MemberDto(memberUsername: element)); }
                  Map res = await  chatApi.editGroupChat(ChatDto(id: groupChat.id, name: chatName,
                      members: m, authorId: groupChat.authorId.toString(), chatImage: '', image: addImage.data));
                  if(res.keys.first == 'Error')
                  {
                    infoDialog(context, res.toString());
                  }
                  else
                  {
                    editChatDialog(context, res.toString());
                  }

                } : null,
                  child: Text(Localization
                      .localizationData[config.language]['editGroupScreen']['goButton'],),
                )),

        ],)

      ],)
    )
                    )
          ]);
  }

}

editChatDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            text,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
