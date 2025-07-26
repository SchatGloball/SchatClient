import 'package:flutter/material.dart';
import '../eventStore.dart';
import '../localization/localization.dart';
import '../user/userScreen.dart';





class CreateChatPage extends StatefulWidget
{
  const CreateChatPage({super.key});

  @override
  State<CreateChatPage> createState() => _CreateChatPage();
}

class _CreateChatPage extends State<CreateChatPage> {


  @override
  void initState() {
    super.initState();
  }

int membersLength()
{
  int i = 0;
  for (var value in members) {
    if(value['added'])
    {++i;}
  }
  return i;
}



  List<Map> members = [{'userName': userGlobal.userName, 'imageAvatar': userGlobal.imageAvatar, 'added': true}];
  String chatName = '';

  searchUser(String memberName) async
  {
    List<Map> newMembers = [];
    for (Map value in members) {
      if(value['added'])
        {
          newMembers.add(value);
        }
    }
    Map res = await userApi.searchUser(memberName);
    if (res.keys.first == 'Error') {

    }
    else {
      for (var e in res['users']) {
        newMembers.add({'userName': e.username, 'imageAvatar': e.imageAvatar, 'added': false});
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
                    Center(
    child: Container(
      height: MediaQuery.of(context).size.height*0.95,
      width: MediaQuery.of(context).size.width*0.95,
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
              .localizationData[config.language]['createChatScreen']['findUsers'],
              style: Theme.of(context).textTheme.titleMedium),
          Text(Localization
              .localizationData[config.language]['createChatScreen']['members'],
              style: Theme.of(context).textTheme.titleMedium),
          SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 3.5,
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
                              trailing: index !=0 ? IconButton(
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
                onChanged: (String value) {
                  setState(() {
                    chatName = value;
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
              if(chatName == '' && membersLength() > 2)
                Text(
                  Localization
                      .localizationData[config.language]['createChatScreen']['notFoundChatName'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
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
              (membersLength() == 2||membersLength() >= 3 && chatName != '') ?
                  () async {

                for (var element in members) {
                  if(!element['added'])
                    {
                      members.remove(element);
                    }
                }
                setState(() {

                });
                Map response = await chatApi.createChat(
                    chatName, members);
                if (response.keys.first == 'status') {
                  showMyDialog(context, 'Chat success');
                }
                else {
                  showMyDialog(context, response['Error']);
                }
              } : null,
                child: Text(Localization
                    .localizationData[config.language]['createChatScreen']['goButton'],),
              )),
        ],),
    ),
    )


                    )
          ]);
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



