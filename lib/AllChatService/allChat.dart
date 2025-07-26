import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:protobuf/protobuf.dart';
import '../AllSocial/allGroup.dart';
import '../CreateChatService/createChat.dart';
import '../DataClasses/UserData.dart';
import '../DataClasses/callData.dart';
import '../DataClasses/chatData.dart';
import '../LoginService/login.dart';
import '../MessageService/message.dart';
import '../SettingsService/settingsScreen.dart';
import '../WidescreenChat/chatAll.dart';
import '../appTheme.dart';
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

  //late StreamSubscription streamSubscription;

  @override
  void dispose() {
    chatApi.updateEvent.cancel();
    if (!config.widescreen) {
      eventStream.cancel();
    }
    super.dispose();
  }

  downloadChats() async {
    allChats.clear();
    Map chatsIsServer = await chatApi.viewAllChat();
    PbList<ChatDto> m = chatsIsServer['chats'];
    for (var e in m) {
      setState(() {
        allChats.add(Chat(e));
      });
    }
    eventStream = chatApi.eventController.stream.listen((item) {
      updateChat(item);
    });
    listenEventChat();

    StreamSubscription streamCall = callApi.eventController.stream.listen((
      item,
    ) {
      Call call = Call();
      call.id = item.room;
      for (var element in item.users) {
        call.users.add(User(12, element.username, element.imageAvatar));
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => CallPage(call: call),
        ),
      );
    });
  }

  updateChat(item) {
    bool newChat = true;
    bool addNotification = true;
    if (item.runtimeType == UpdateDTO) {
      UpdateDTO updateChat = item;
      if (updateChat.chat.authorId == '-1') {
        removeChatUpdate(updateChat.chat.id);
      }
      for (int i = 0; i < allChats.length; i++) {
        if (allChats[i].id == updateChat.chat.id) {
          newChat = false;
          if (updateChat.chat.messages.isNotEmpty) {
            for (MessageDto m in updateChat.chat.messages) {
              bool newMessage = true;
              for (int y = 0; y < allChats[i].messages.length; y++) {
                if (allChats[i].messages[y].id == m.id) {
                  newMessage = false;
                  allChats[i].messages[y] = Message(m);
                  allChats[i].messages[y].body =
                      '${allChats[i].messages[y].body} ';
                }
              }
              if (Message(m).authorId == userGlobal.id) {
                addNotification = false;
              }
              if (newMessage) {
                allChats[i].addMessage(m, true);
              }
            }
          } else {
            List<Message> m = allChats[i].messages;
            allChats[i] = Chat(
              ChatDto(
                name: updateChat.chat.name,
                chatImage: updateChat.chat.chatImage,
                id: updateChat.chat.id,
                authorId: updateChat.chat.authorId.toString(),
                members: updateChat.chat.members,
              ),
            );
            allChats[i].messages = m;
          }
        }
      }
      if (newChat) {
        addNewChat(updateChat.chat);
      }
    } else {
      addNotification = false;
    }
    if (addNotification && config.notification) {
      player.playNotification();
      notification.newEvent(
        'Schat',
        Localization.localizationData[config
            .language]['notification']['newMessage'],
      );
    }
    allChats.sort((b, a) => a.dateLastMessage.compareTo(b.dateLastMessage));
    setState(() {});
  }

  removeChatUpdate(int id) {
    for (int i = 0; i < allChats.length; i++) {
      if (allChats[i].id == id) {
        allChats.removeAt(i);
      }
    }
  }

  addNewChat(ChatDto chat) {
    allChats.add(Chat(chat));
  }

  deliveredMessage(int id) {
    for (var element in allChats) {
      if (element.id == id && element.messages.isNotEmpty) {
        if (element.messages.first.authorId != userGlobal.id) {
          setState(() {
            element.messages.first.delivered = true;
          });
        }
      }
    }
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: config.accentColor,
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
                  icon: const Icon(Icons.refresh, color: Colors.white54),
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
            child: ListView.builder(
              itemCount: allChats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54,
                      ),
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.all(5)),
                          Row(
                            children: [
                              const Padding(padding: EdgeInsets.all(5)),
                              if (allChats[index].chatImage == '' ||
                                  allChats[index].chatImage == 'null')
                                CircleAvatar(
                                  child: Icon(
                                    color: config.accentColor,
                                    Icons.person,
                                  ),
                                ),
                              if (allChats[index].chatImage.toString() !=
                                      'null' &&
                                  allChats[index].chatImage.toString() != '')
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    allChats[index].chatImage.toString(),
                                  ),
                                ),
                              const Padding(padding: EdgeInsets.all(12)),
                              Text(
                                allChats[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(padding: EdgeInsets.all(20)),
                              if (allChats[index].messages.isNotEmpty)
                                Expanded(
                                  child: Text(
                                    '${allChats[index].messages.first.authorName}: ${allChats[index].messages.first.body}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              if (allChats[index].messages.isNotEmpty &&
                                  allChats[index].messages.first.delivered)
                                const Icon(
                                  Icons.check_sharp,
                                  color: Colors.white70,
                                ),
                              if (allChats[index].messages.isNotEmpty &&
                                  !allChats[index].messages.first.delivered &&
                                  allChats[index].messages.first.authorId !=
                                      userGlobal.id)
                                Text(
                                  Localization.localizationData[config
                                          .language]['allChatScreen']['newMessage'] +
                                      '  ',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      deliveredMessage(allChats[index].id);
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
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black54,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const CreateChatPage(),
                ),
              );
              //  updateSleepChat();
            },
            child: Icon(Icons.message_rounded, color: config.accentColor),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black54,
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
            currentIndex: 0,
            selectedItemColor: config.accentColor,
            unselectedItemColor: config.accentColor,
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
