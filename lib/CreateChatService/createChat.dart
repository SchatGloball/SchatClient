import 'package:flutter/material.dart';
import 'package:schat2/DataClasses/chatData.dart';
import 'package:schat2/DataClasses/file.dart';
import 'package:schat2/allWidgets/infoDialog.dart';
import 'package:schat2/env.dart';
import 'package:schat2/generated/chats.pb.dart';
import '../eventStore.dart';
import '../localization/localization.dart';
import '../user/userScreen.dart';





class CreateChatPage extends StatefulWidget
{
   CreateChatPage({super.key, required this.chat});
late Chat chat;
  @override
  State<CreateChatPage> createState() => _CreateChatPage(chat: chat);
}

class _CreateChatPage extends State<CreateChatPage> {
late Chat chat;
_CreateChatPage({required this.chat});



TextEditingController chatNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    chatNameController.text = chat.name;
    for (var m in chat.members) {
members.add({'userName': m, 'imageAvatar': '', 'added': true, 'rootMember': true});
    }
    if(members.isEmpty)
    {members.add({'userName': config.server.userGlobal.userName, 'imageAvatar': config.server.userGlobal.imageAvatar, 'added': true, 'rootMember': true});}
  }

FileData fileImage = FileData('', [], '');

int membersLength()
{
  int i = 0;
  for (var value in members) {
    if(value['added'])
    {++i;}
  }
  return i;
}



  List<Map> members = [];

  searchUser(String memberName) async
  {
    List<Map> newMembers = [];
    for (Map value in members) {
      if(value['added'])
        {
          newMembers.add(value);
        }
    }
    Map res = await config.server.userApi.searchUser(memberName);
    if (res.keys.first == 'Error') {

    }
    else {
      for (var e in res['users']) {
        newMembers.add({'userName': e.username, 'imageAvatar': e.imageAvatar, 'added': false, 'rootMember': false});
      }
    }
    members.clear();
    setState(() {
members.addAll(newMembers);
    });
  }
sortMembers()
{
  members.sort((a, b) {
    final bool aAdded = a['added'] as bool? ?? false;
    final bool bAdded = b['added'] as bool? ?? false;

    if (aAdded == bAdded) return 0;   // одинаковое значение – порядок не меняем
    return aAdded ? -1 : 1;           // true идёт выше false
  });
  setState(() {

  });
}

  @override
  Widget build(BuildContext context) {
    return
     LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
        double size = screenSize.width > screenSize.height?config.maxHeightWidescreen:0.95;
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
                 
                  leading: BackButton(
                      color: Colors.white54,
                      onPressed: (){
                        Navigator.of(context).pop();}
                  ),
                  automaticallyImplyLeading: false,
                ),
             
                body:


                SafeArea(child:
                Center(
    child: Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      width: MediaQuery.of(context).size.width * size,
      padding: const EdgeInsets.all(10),
      color: Colors.black54,
      child: Column(
        children: [
          Text(Localization
              .localizationData[config.language]['createChatScreen']['title'],
              style: Theme.of(context).textTheme.titleMedium
          ),
          TextField(
            onChanged: (String value) {
              searchUser(value);
            },
            decoration: InputDecoration(
              labelText: Localization
                  .localizationData[config.language]['createChatScreen']['nameUser'],
              labelStyle: Theme.of(context).textTheme.titleLarge,
            ),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(Localization
              .localizationData[config.language]['createChatScreen']['members'],
              style: Theme.of(context).textTheme.titleMedium),
          Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return
                    Card(
                      color: members[index]['added'] ? config.accentColor : Colors.white30,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => UserPage(userName: members[index]['userName'],)));
                            },
                            child: ListTile(
                              leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                if(members[index]['imageAvatar'] ==
                                    '')
                                  const Icon(Icons.person),
                                if(members[index]['imageAvatar'] !=
                                    '')
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        members[index]['imageAvatar']),
                                  )
                              ]),
                              title: Text(members[index]['userName'], style: Theme.of(context).textTheme.titleMedium,),
                              trailing: !members[index]['rootMember'] ? IconButton(
                                color: Colors.white70,
                                icon: members[index]['added'] ? const Icon(Icons.delete_forever) : const Icon(Icons.add),
                                onPressed: () {
                                  if(!members[index]['added'])
                                  {
                                    for(Map m in members)
                                      {
                                        if(m['userName'] == members[index]['userName'] && m['added'])
                                          {
                                            setState(() {
                                              members.remove(members[index]);
                                              return;
                                            });
                                          }
                                      }
                                    members[index]['added'] = true;
                                  }
                                  else
                                  {
                                    members[index]['added'] = false;
                                  }
                                  sortMembers();
                                },
                              ): null,
                            ),
                          ),
                        ],
                      ),
                    );
                },
              )
          ),

          Column(children: [
            if(membersLength() > 2)
              TextField(
                controller: chatNameController,
                onChanged: (String value) {
                  setState(() {
                    chat.name = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: Localization
                      .localizationData[config.language]['createChatScreen']['nameChat'],
                  labelStyle: Theme.of(context).textTheme.titleLarge,
                ),
                style: Theme.of(context).textTheme.titleLarge,
              )
          ],),
          Column(
            children: [
              if(chat.name == '' && membersLength() > 2)
                Text(
                  Localization
                      .localizationData[config.language]['createChatScreen']['notFoundChatName'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                )
            ],
          ),
         const Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 3)),
          if(members.length>2)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [IconButton(onPressed: ()async{

  try{
    List<FileData> files = await pickFiles();
    if(files.isNotEmpty && Env.image.contains(files.last.extension)) {
      fileImage = files.last;
      setState(() {
        
      });
    }
    else
    {
      infoDialog(context, 'Error file');
    }
    }
  catch(e)
  {
infoDialog(context, e.toString());
  }
            }, icon: const Icon(Icons.image)), 
            if(chat.chatImage.isNotEmpty && fileImage.data.isEmpty)
            CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      chat.chatImage),
                                )
            
            ],
          ), 
          Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.5,
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(onPressed:
              (membersLength() == 2||membersLength() >= 3 && chat.name != '') ?
                  () async {
                    if(chat.id==-1)
                    {
                      members.removeWhere((member) => !member['added']);
                setState(() {
                });
                Map response = await config.server.chatApi.createChat(
                    chat.name, members);
                if (response.keys.first == 'status') {
                  showMyDialog(context, 'Chat success');
                }
                else {
                  showMyDialog(context, response['Error']);
                }
                    }
                    else
                    {
                      List<MemberDto> memb = [];
List<String> mmm = [];
                      for (var element in members) {
                  if(element['added'])
                    {
                      mmm.add(element['userName']);
                     
                    }
                }
    mmm = List<String>.from(
        mmm.toSet()); //оставляем только уникальные элементы

 for (var element in mmm) {
                  memb.add(MemberDto(memberUsername: element));
                    }


                        Map res = await  config.server.chatApi.editGroupChat(ChatDto(id: chat.id, name: chat.name,
                      members: memb, authorId: chat.authorId.toString(), chatImage: '', image: fileImage.data));
                  if(res.keys.first == 'Error')
                  {
                    showMyDialog(context, res.toString());
                  }
                  else
                  {
                    showMyDialog(context, res.toString());
                  }
                    }
                
              } : null,
                child: chat.id == -1 ? Text(Localization
                    .localizationData[config.language]['createChatScreen']['goButton'],): Text(Localization
                    .localizationData[config.language]['createChatScreen']['goEditButton'],),
              )),
        ],),
    ),
    )
                )
                    


                    )
          ]);});
  }
  showMyDialog(BuildContext context, text) {
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
                },
              ),
            ],
          );
        });
  }
}



