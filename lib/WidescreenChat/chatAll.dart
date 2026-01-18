import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:protobuf/protobuf.dart';
import 'package:provider/provider.dart';
import 'package:schat2/%D0%A1allService/callScreen.dart';
import 'package:schat2/AllChatService/allChat.dart';
import 'package:schat2/AllChatService/chatCard.dart';
import 'package:schat2/AllChatService/messageProvider.dart';
import 'package:schat2/DataClasses/UserData.dart';
import 'package:schat2/DataClasses/callData.dart';
import 'package:schat2/WidescreenChat/actionButton.dart';
import 'package:schat2/MessageService/messageMenu.dart';
import 'package:schat2/MessageService/sendReaction.dart';
import 'package:schat2/MessageService/sendSticker.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:super_hot_key/super_hot_key.dart';
import '../CreateChatService/createChat.dart';
import '../DataClasses/chatData.dart';
import '../DataClasses/file.dart';
import '../MessageService/OneMessageWidget.dart';
import '../MessageService/audioRecorder.dart';
import '../allWidgets/acceptDialog.dart';
import '../allWidgets/infoDialog.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart';
import '../localization/localization.dart';
import '../user/userScreen.dart';

class AllChatWidescreenPage extends StatefulWidget {
  const AllChatWidescreenPage({super.key});

  @override
  State<AllChatWidescreenPage> createState() => _AllChatWidescreen();
}

class _AllChatWidescreen extends State<AllChatWidescreenPage> {
  @override
  void initState() {
    super.initState();
    downloadChats();
  }

  bool stickerPick = false;
 
  
  ScrollController scrollController = ScrollController();
  List<FileData> filesPick = [];
  String message = '';
  final fieldText = TextEditingController();
  late final HotKey? hotKeySend;
 
  bool replyMessage = false;
  bool bottomButtonView = false;

  @override
  void dispose() {
    config.server.chatApi.updateEvent.cancel();
    hotKeySend!.dispose();
    super.dispose();
  }

  

  removeMessages()async
  {
    for (var item in selectedMessages) {
                                              Map res = await config.server.chatApi
                                                  .removeMessage(item);
                                              if (res.keys.first == 'Error') {
                                                infoDialog(
                                                  context,
                                                  res['Error'],
                                                );
                                              } else {
                                                setState(() {
                                                  allChats[selectChat].messages
                                                      .removeWhere(
                                                        (element) =>
                                                            element.id == item,
                                                      );
                                                });
                                              }
                                            }
                                            setState(() {
                                              selectedMessages.clear();
                                            });
  }

  activateReplyMessage()
  {
    setState(() {
                                                replyMessage = true;
                                              });
  }

  pickFile() async {
    filesPick = await pickFiles();
    setState(() {});
  }

  void updateParent() {
    stickerPick = false;
    selectedMessages.clear();
    replyMessage = false;
    setState(() {});
  }

  scrollDown() async {
    if (allChats[selectChat].messages.isNotEmpty) {
      
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
    setState(() {
        
      });
  }

  initData() async {
    if (allChats[selectChat].messages.length < 50) {
      await downloadChat(allChats[selectChat].messages.length);
    }
    scrollController.addListener(scrollUpdate); //отслеживание прокрутки
  }

  sendMessage() async {
    if (message != '' || filesPick.isNotEmpty) {
      if (message == '') {
        message = 'media';
      }
      setState(() {
        uploadData = true;
      });
      Map send = await config.server.chatApi.sendMessages(
        allChats[selectChat].id,
        message,
        filesPick,
      );
      fieldText.clear();
      setState(() {
        uploadData = false;
      });
      if (send.keys.first == 'Error') {
        infoDialog(context, send['Error']);
      } else {
        message = '';
        setState(() {
          filesPick.clear();
        });
      }
    }
  }

  scrollUpdate() {
    //отслеживание положения прокрутки сообщений
    if (scrollController.offset == scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      downloadChat(allChats[selectChat].messages.length);
    }
    if (scrollController.offset > 250) {
      setState(() {
        bottomButtonView = true;
      });
    }
    if (scrollController.offset < 250) {
      setState(() {
        bottomButtonView = false;
      });
    }
  }

  downloadChat(int offset) async {
    Map messages = await config.server.chatApi.viewMessagesChat(
      allChats[selectChat].id,
      offset,
    );
    setState(() {
      for (var element in messages['chat'].messages ?? []) {
        allChats[selectChat].messages.add(Message(element));
      }
    });
  }








  updateChat(UpdateDTO item) {
    final MessageProvider messageProvider = Provider.of<MessageProvider>(context, listen: false);
    messageProvider.newMessageEvent(item);
    setState(() {
      for(int i = 0; i < allChats.length; i++)
      {
        if(allChats[i].id == selectChatId)
        {
selectChat = i;
        }
      }
       
    });
  }


  void downloadChats() async {
    allChats.clear();
    Map chatsIsServer = await config.server.chatApi.viewAllChat();
    PbList<ChatDto> m = chatsIsServer['chats'];
    for (var e in m) {
      setState(() {
        allChats.add(Chat(e));
      });
    }
    listenChatEvent();
    if (allChats.isNotEmpty) {
      initData();
    }
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
      if(activeCall.isNotEmpty)
      {
        return;
      }
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





  deleteChat() async {
    final int id = allChats[selectChat].id;
    Map res = await config.server.chatApi.removeChat(id);
    if (res.keys.first != 'Error') {
      final int oldSelect = selectChat;
      setState(() {
        if (allChats.length > 1) {
          if (allChats.first.id != id) {
            selectChat = 0;
          } else {
            selectChat = 1;
          }
          downloadChat(allChats[selectChat].messages.length);
        }
        allChats.remove(allChats[oldSelect]);
      });
    } else {
      infoDialog(context, res['Error']);
    }
  }


  clipboard() async {
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return; // Clipboard API is not supported on this platform.
    }
    final reader = await clipboard.read();

    if (reader.canProvide(Formats.htmlText)) {
      final html = await reader.readValue(Formats.htmlText);
      setState(() {
        message = message + html.toString();
        fieldText.text = html.toString();
      });
    }

    if (reader.canProvide(Formats.plainText)) {
      final String? text = await reader.readValue(Formats.plainText);
      setState(() {
        message = message + text.toString();
        fieldText.text += text.toString();
      });
    }

    /// Binary formats need to be read as streams
    if (reader.canProvide(Formats.png) ||
        reader.canProvide(Formats.jpeg) ||
        reader.canProvide(Formats.webp)) {
      reader.getFile(Formats.png, (file) async {
        Uint8List fileBytes = await file.readAll();
        filesPick.add(FileData('', fileBytes, 'screen.png'));
        setState(() {});
      });
    }
  }

  searchMessageChat(String searchKey) async {
    searchMessage.clear();
    List<MessageDto> res = await config.server.chatApi.searchMessage(
      searchKey,
      allChats[selectChat],
    );
    for (var element in res) {
      searchMessage.add(Message(element));
    }
    setState(() {});
  }

  viewSearchMessage(int messageId) async {
    for (int i = 0; i < allChats[selectChat].messages.length; i++) {
      if (allChats[selectChat].messages[i].id == messageId) {
        if (allChats[selectChat].messages[i].id !=
            allChats[selectChat].messages.last.id) {
          allChats[selectChat].messages.removeRange(
            i + 2,
            allChats[selectChat].messages.length,
          );
        }
        setState(() {});
        scrollController.jumpTo(scrollController.position.maxScrollExtent - 20);
        setState(() {});
        return;
      }
    }
    await downloadChat(allChats[selectChat].messages.length);
    viewSearchMessage(messageId);
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
            title: searchActive
                ? TextField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.length > 2) {
                        searchMessageChat(value);
                      } else {
                        searchMessageSelect = 0;
                        searchMessage.clear();
                      }
                    },
                  )
                : null,
            actions: [
              if (searchMessage.isNotEmpty)
                IconButton(
                  onPressed: () async {
                    if (searchMessageSelect < searchMessage.length - 1) {
                      searchMessageSelect++;
                    } else {
                      searchMessageSelect = 0;
                    }

                    viewSearchMessage(searchMessage[searchMessageSelect].id);
                  },
                  icon: const Icon(
                    Icons.navigate_before_sharp,
                    color: Colors.white54,
                  ),
                ),
              if (searchMessage.isNotEmpty)
                Text(
                  '${searchMessage.length}',
                  style: const TextStyle(color: Colors.white54),
                ),
              if (searchMessage.isNotEmpty)
                IconButton(
                  onPressed: () async {
                    if (searchMessageSelect > 0) {
                      searchMessageSelect -= 1;
                    } else {
                      searchMessageSelect = searchMessage.length - 1;
                    }

                    viewSearchMessage(searchMessage[searchMessageSelect].id);
                  },
                  icon: const Icon(
                    Icons.navigate_next_sharp,
                    color: Colors.white54,
                  ),
                ),
              if (allChats.isNotEmpty)
                IconButton(
                  onPressed: () async {
                    if (searchActive) {
                      searchMessageSelect = 0;
                      searchMessage.clear();
                      searchActive = false;
                    } else {
                      searchActive = true;
                    }
                    setState(() {});
                  },
                  icon: Icon(
                    searchActive
                        ? Icons.backspace_outlined
                        : Icons.search_outlined,
                    color: Colors.white54,
                  ),
                ),
              if (allChats.isNotEmpty && !searchActive)
                IconButton(
                  onPressed: () async {
                    bool? accepted = await acceptDialog(
                      context,
                      Localization.localizationData[config
                          .language]['messageScreen']['deleteDialog'],
                    );
                    if (accepted!) {
                      deleteChat();
                    }
                  },
                  icon: const Icon(Icons.delete_forever, color: Colors.white54),
                ),
              if (!config.isWeb && !searchActive)
                IconButton(
                  onPressed: () async {
                    if (!config.widescreen) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllChatPage(),
                        ),
                      );
                      return;
                    }
               downloadChat(allChats[selectChat].messages.length);   
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white54),
                ),
            ],
          ),
          body: Row(
            children: [
              Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: ListView.builder(
                    itemCount: allChats.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: InkWell(
                          child: ChatCard(index),
                          onTap: () async {
                            if (index == selectChat) {
                              if (allChats[index].members.length == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => UserPage(
                                      userName:
                                          allChats[index].members.first ==
                                              config.server.userGlobal.userName
                                          ? allChats[index].members.last
                                          : allChats[index].members.first,
                                    ),
                                  ),
                                );
                              } else {
                                List<MemberDto> members = [];
                        for(String m in allChats[selectChat].members)
                        {
members.add(MemberDto(memberUsername: m, memberImage: ''));
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CreateChatPage(chat: Chat(ChatDto(authorId: allChats[selectChat].authorId.toString(), id: allChats[selectChat].id, name: allChats[selectChat].name, messages: [], members: members, chatImage: allChats[selectChat].chatImage, image: [])),),
                          ),
                        );
                              }
                            }
                            else{
                              final MessageProvider messageProvider = Provider.of<MessageProvider>(context, listen: false);
                  messageProvider.deliveredMessage(allChats[index].id);
                              selectChat = index;
                              selectChatId = allChats[index].id;
                              initData();
                              scrollDown();
                            }
                             
                          },
                        ),
                      );
                    },
                  ),
                
              ),
             const Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 5)),
              if (allChats.isNotEmpty)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (allChats.isNotEmpty)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height:
                              MediaQuery.of(context).size.height * 0.86 -
                              kToolbarHeight,
                          child: ListView.builder(
                            reverse: true,
                            shrinkWrap: false,
                            itemCount: allChats[selectChat].messages.length,
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Column(
                                  children: [
                                    if (allChats[selectChat]
                                            .messages[index]
                                            .authorId ==
                                        config.server.userGlobal.id)
                                      InkWell(
                                        onLongPress: () {
                                          setState(() {
                                            selectedMessages.add(
                                              allChats[selectChat]
                                                  .messages[index],
                                            );
                                          });
                                        },
                                        onTap: selectedMessages.isNotEmpty
                                    ? () {
                                        setState(() {
                                          if (!selectedMessages.contains(
                                            allChats[selectChat].messages[index],
                                          )) {
                                            selectedMessages.add(
                                              allChats[selectChat].messages[index],
                                            );
                                          } else {
                                            selectedMessages.remove(
                                              allChats[selectChat].messages[index],
                                            );
                                          }
                                        });
                                      }
                                    : null,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                selectedMessages.contains(
                                                  allChats[selectChat]
                                                      .messages[index]
                                                      .id,
                                                )
                                                ? config.accentColor
                                                : Colors.black87,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: const Alignment(10, 7),
                                              colors: <Color>[
                                                Colors.black,
                                                config.accentColor,
                                                Colors.black,
                                              ],
                                              tileMode: TileMode.mirror,
                                            ),
                                          ),
                                          child: MessageOne(
                                            message: allChats[selectChat]
                                                .messages[index],
                                          ),
                                        ),
                                      ),
                                    if (allChats[selectChat]
                                            .messages[index]
                                            .authorId !=
                                        config.server.userGlobal.id)
                                        InkWell(
  onTap: selectedMessages.isNotEmpty
                                    ? () {
                                        setState(() {
                                          if (!selectedMessages.contains(
                                            allChats[selectChat].messages[index],
                                          )) {
                                            selectedMessages.add(
                                              allChats[selectChat].messages[index],
                                            );
                                          } else {
                                            selectedMessages.remove(
                                              allChats[selectChat].messages[index],
                                            );
                                          }
                                        });
                                      }
                                    : null,
                                onLongPress: () {
                                  setState(() {
                                    selectedMessages.add(allChats[selectChat].messages[index]);
                                  });
                                },
                                          child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: const Alignment(0.4, 7),
                                            colors: <Color>[
                                              Colors.black,
                                              Colors.black,
                                              Colors.black,
                                              Colors.black,
                                              Colors.black,
                                              Colors.black,
                                              config.accentColor,
                                              Colors.black,
                                            ],
                                            tileMode: TileMode.mirror,
                                          ),
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: MessageOne(
                                          message: allChats[selectChat]
                                              .messages[index],
                                        ),
                                      ),
                                        )
                                      ,
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height:
                            MediaQuery.of(context).size.height * 0.18 -
                            kToolbarHeight,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final parentWidth = constraints.maxWidth;
                            final parentHeight = constraints.maxHeight;
                            return Column(
                              children: [
                                if (replyMessage)
                                  SendReaction(
                                    updateParent: updateParent,
                                    messageId: selectedMessages.first.id,
                                  ),
                                if (selectedMessages.isEmpty &&
                                    !recordAudio &&
                                    !stickerPick &&
                                    !replyMessage)
                                  Container(
                                    height: parentHeight,
                                    width: parentWidth,
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          
                                          tooltip:
                                              Localization
                                                  .localizationData[config
                                                  .language]['messageScreen']['paste'],
                                          style: TextButton.styleFrom(
                                            
                                          ),
                                          icon: Icon(
                                            Icons.paste,
                                            size: 40,
                                            
                                          ),
                                          onPressed: () {
                                            clipboard();
                                          },
                                        ),
                                        IconButton(                     
                                          style: TextButton.styleFrom(
                                          ),
                                          icon: Icon(
                                            Icons.insert_emoticon_sharp,
                                            size: 40,
                                            
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              stickerPick = true;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          style: TextButton.styleFrom(
                                          ),
                                          icon: filesPick.isEmpty
                                              ? Icon(
                                                  Icons.add_a_photo_outlined,
                                                  size: 40,
                                                )
                                              : Icon(
                                                  Icons.delete_forever,
                                                  size: 40,
                                                ),
                                          onPressed: () {
                                            if (filesPick.isNotEmpty) {
                                              setState(() {
                                                filesPick.clear();
                                              });
                                              return;
                                            }
                                            pickFile();
                                          },
                                        ),
                                        Expanded(child: Container(
                                          padding: const EdgeInsets.only(
                                            left: 6,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                
                                                textInputAction: TextInputAction.send,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                                cursorColor: config.accentColor,
                                                controller: fieldText,
                                                minLines: 1,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: 4,
                                                onChanged: (String value) {
                                                  
                                                  message = value;
                                                },
                                                 onSubmitted: (value)async {
    await sendMessage();
  },
                                              ),
                                            ],
                                          ),
                                        ))
                                        ,
                                        const Padding(
                                          padding: EdgeInsets.all(10),
                                        ),
                                        uploadData
                                            ? Lottie.asset('assets/loader.json')
                                            : InkWell(
                                                onTap: () async {
                                                  sendMessage();
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
                                      ],
                                    ),
                                  ),
                                if (selectedMessages.isEmpty &&
                                    recordAudio &&
                                    !replyMessage)
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.15 -
                                        kToolbarHeight,
                                    width: parentWidth * 0.95,
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: AudioRecorderPage(
                                      updateParent: updateParent,
                                      chatId: allChats[selectChat].id,
                                    ),
                                  ),
                                if (selectedMessages.isNotEmpty &&
                                    !replyMessage)
MessageMenu(context, updateParent: updateParent, activateReplyMessage: activateReplyMessage, removeMessages: removeMessages,), 
                                if (stickerPick)
                                  SendSticker(
                                    updateParent: updateParent,
                                    chatId: allChats[selectChat].id,
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ), 

              if(bottomButtonView)
              IconButton(onPressed: (){scrollDown();}, icon: Icon(Icons.arrow_drop_down_circle_outlined,
                    ))
            ],
          ),
          floatingActionButton: ActionButton(updateParent: updateParent),
        ),
      ],
    );
  }
}
