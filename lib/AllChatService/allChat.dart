
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:protobuf/protobuf.dart';
import 'package:provider/provider.dart';
import 'package:schat2/AllChatService/chatCard.dart';
import 'package:schat2/AllChatService/messageProvider.dart';
import 'package:schat2/DataClasses/UserData.dart' show User;
import '../AllSocial/allGroup.dart';
import '../CreateChatService/createChat.dart';
import '../DataClasses/callData.dart';
import '../DataClasses/chatData.dart';
import '../MessageService/message.dart';
import '../SettingsService/settingsScreen.dart';
import '../WidescreenChat/chatAll.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart';
import '../localization/localization.dart';
import '../user/UserGeneral.dart';
import '../СallService/callScreen.dart';

class AllChatPage extends StatefulWidget {
  const AllChatPage({super.key});

  @override
  State<AllChatPage> createState() => _AllChat();
}

class _AllChat extends State<AllChatPage> {
  @override
  void initState() {
    super.initState();
    downloadChats();
  }

  @override
  void dispose() {
    config.server.chatApi.updateEvent.cancel();
    if (!config.widescreen) {
      eventStream.cancel();
    }
    streamCallSubscription?.cancel();
    super.dispose();
  }


listenChatEvent()
{
  listenEventChat();
eventStream = config.server.chatApi.updateEvent.listen((UpdateDTO item) {
      updateChat(item);
    },

onDone: ()async{
      print('onDone eventStream');
      Future.delayed(const Duration(seconds: 2), () async{
        await config.server.refreshTokens();
 listenChatEvent();
      });
    }, onError: (e)async{
      print('Error eventStream  $e');
 Future.delayed(const Duration(seconds: 2), () async{
        await config.server.refreshTokens();
  listenChatEvent();
      });
    }
    );
    streamCallSubscription = config.server.callApi.updateEvent.listen((
      item,
    ) {
      Call call = Call();
      call.id = item.room;
      for (var element in item.users) {
        call.users.add(User(12, element.username, element.imageAvatar, false));
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => CallPage(call: call),
        ),
      );
    }, onDone: ()async{
      print('onDone eventCallStream');
      Future.delayed(const Duration(seconds: 2), () async{
        await config.server.refreshTokens();
 listenChatEvent();
      });
    }, onError: (e)async{
      print('Error eventCallStream  $e');
 Future.delayed(const Duration(seconds: 2), () async{
        await config.server.refreshTokens();
 listenChatEvent();
      });
    }
     );
}



  downloadChats() async {
    allChats.clear();
    Map chatsIsServer = await config.server.chatApi.viewAllChat();
    PbList<ChatDto> m = chatsIsServer['chats'];
    for (var e in m) {
      setState(() {
        allChats.add(Chat(e));
      });
    }
    listenChatEvent();
  }
 
  void updateChat(UpdateDTO item) {
    final MessageProvider messageProvider = Provider.of<MessageProvider>(context, listen: false);
    messageProvider.newMessageEvent(item);
  }



  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      config.widescreen = true;
    } else {
      config.widescreen = false;
    }
    return Stack(
      children: [
        Image.asset(
          'assets/${config.backgroundAsset}',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Schat', style: Theme.of(context).textTheme.titleLarge),
            actions: [
              if (!config.isWeb && !Platform.isAndroid)
                IconButton(
                  onPressed: () async {
                    if (config.widescreen) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllChatWidescreenPage(),
                        ),
                      );
                      return;
                    }
                    await refreshApp();
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh),
                ),

              IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SettingsPage(),
                    ),
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await refreshApp();
              setState(() {});
            },
            child: Consumer<MessageProvider>(
              builder: (context, messageProvider, child) {
                return ListView.builder(
                  itemCount: allChats.length,
                  itemBuilder: (context, index) {
                return ListTile(
                  title: InkWell(
                    child: ChatCard(index),
                    onTap: () async {
                      final MessageProvider messageProvider = Provider.of<MessageProvider>(context, listen: false);
                  messageProvider.deliveredMessage(allChats[index].id);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MessagePage(chat: allChats[index]),
                        ),
                      );
                    },
                  ),
                );
                  },
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CreateChatPage(chat: Chat(ChatDto(authorId: config.server.userGlobal.id.toString(), id: -1, name: '', messages: [], members: [], chatImage: '', image: [])),),
                ),
              );
            },
            child: Icon(Icons.message_rounded),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white70,
            selectedItemColor: Colors.white70,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.groups),
                label: 
                    Localization.localizationData[config
                        .language]['allChatScreen']['groups'], 
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label:
                    Localization.localizationData[config
                        .language]['allChatScreen']['profile'],
                        
              ),
            ],
           
            onTap: (int index) async {
              if (index == 0) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const AllGroupsPage(),
                  ),
                );
              }
              if (index == 1) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => UserGeneralPage(),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
