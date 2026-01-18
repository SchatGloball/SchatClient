import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:schat2/AllChatService/messageProvider.dart';
import 'package:schat2/CreateChatService/createChat.dart';
import 'package:schat2/MessageService/messageMenu.dart';
import 'package:schat2/MessageService/sendReaction.dart';
import 'package:schat2/MessageService/sendSticker.dart';
import 'package:uuid/uuid.dart';
import '../DataClasses/chatData.dart';
import '../DataClasses/file.dart';
import '../allWidgets/acceptDialog.dart';
import '../allWidgets/infoDialog.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart';
import '../localization/localization.dart';
import '../user/userScreen.dart';
import 'OneMessageWidget.dart';
import 'audioRecorder.dart';


class MessagePage extends StatefulWidget {
  late Chat chat;
  MessagePage({super.key, required this.chat});

  @override
  State<MessagePage> createState() => _Message(chat: chat);
}

class _Message extends State<MessagePage> {
  late Chat chat;
  String message = '';
  bool replyMessage = false;

  bool stickerPick = false;
  
  var uuid = const Uuid();
  List<FileData> filesPick = [];
  bool bottomButtonView = false;

  _Message({required this.chat});

  ScrollController scrollController = ScrollController();
  final TextEditingController fieldText = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    if (chat.messages.length < 50) {
      await downloadChat(chat.messages.length);
    }
    scrollController.addListener(scrollUpdate); //отслеживание прокрутки
  }

  bool checkRemoveMessages() {
    for (Message m in selectedMessages) {
      if (m.authorId != config.server.userGlobal.id) {
        return false;
      }
    }
    return true;
  }
  activateReplyMessage()
  {
    setState(() {
                                                replyMessage = true;
                                              });
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
                                                  chat.messages
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

  scrollUpdate() {
    //отслеживание положения прокрутки сообщений
    if (scrollController.offset == scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      downloadChat(chat.messages.length);
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
    // if (scrollController.offset < 50) {
    //    final MessageProvider messageProvider = Provider.of<MessageProvider>(context, listen: false);
    // messageProvider.deliveredMessage(chat.id);
    // }
  }

   void updateParent() {
    stickerPick = false;
    selectedMessages.clear();
    replyMessage = false;
    setState(() {});
  }

  @override
  void dispose() {
    fieldText.dispose();
    searchMessageSelect = 0;
    searchMessage.clear();
    searchActive = false;
    super.dispose();
  }

  scrollDown() async {
    if (chat.messages.isNotEmpty) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      final MessageProvider messageProvider = Provider.of<MessageProvider>(context, listen: false);
    messageProvider.deliveredMessage(chat.id);
    }
  }

  pickFile() async {
    filesPick = await pickFiles();
    setState(() {});
  }

  downloadChat(int offset) async {
    Map messages = await config.server.chatApi.viewMessagesChat(chat.id, offset);
    if (messages.keys.contains('Error')) {
      infoDialog(context, messages.toString());
      return;
    }
    setState(() {
      for (var element in messages['chat'].messages) {
        chat.messages.add(Message(element));
      }
    });
  }

  sendMessage() async {
    if (message != '' || filesPick.isNotEmpty) {
      if (message == '') {
        message = 'media';
      }
      setState(() {
        uploadData = true;
      });
      
      Map send = await config.server.chatApi.sendMessages(chat.id, message, filesPick);
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

  sendReaction() async {
    if (message == '') {
      selectedMessages.clear();
      filesPick.clear();
    }
    ReactionMessage req = ReactionMessage(
      ReactionMessageDto(
        id: 0,
        body: message,
        authorId: config.server.userGlobal.id,
        authorName: config.server.userGlobal.userName,
        messageId: selectedMessages.first.id,
        stickerContent: 0,
        dateReaction: DateTime.now().toString(),
      ),
    );
    Map send = await config.server.chatApi.sendReaction(req);
    if (send.keys.first == 'Error') {
      infoDialog(context, send['Error']);
    } else {
      message = '';
      filesPick.clear();
      selectedMessages.clear();
      replyMessage = false;
    }

    setState(() {});
  }

  

  updateMessagesChat(item) {
    if (item.runtimeType == UpdateDTO) {
      UpdateDTO messagesUpdate = item;
      if (mounted) {
        setState(() {});
        if (messagesUpdate.chat.id == chat.id) {
          scrollDown();
        }
      }
    } else {
      setState(() {});
    }
  }

  deleteChat() async {
    Map res = await config.server.chatApi.removeChat(chat.id);
    if (res.keys.first != 'Error') {
      setState(() {
        allChats.remove(chat);
      });
      Navigator.pop(context);
    } else {
      infoDialog(context, res['Error']);
    }
  }

  searchMessageChat(String searchKey) async {
    searchMessage.clear();
    List<MessageDto> res = await config.server.chatApi.searchMessage(searchKey, chat);
    for (var element in res) {
      searchMessage.add(Message(element));
    }
    setState(() {});
  }

  viewSearchMessage(int messageId) async {
    for (int i = 0; i < chat.messages.length; i++) {
      if (chat.messages[i].id == messageId) {
        if (chat.messages[i].id != chat.messages.last.id) {
          chat.messages.removeRange(i + 2, chat.messages.length);
        }
        setState(() {});
        scrollController.jumpTo(scrollController.position.maxScrollExtent - 20);
        setState(() {});
        return;
      }
    }
    await downloadChat(chat.messages.length);
    viewSearchMessage(messageId);
  }

  @override
  Widget build(BuildContext context) {
    // Слушаем изменения MessageProvider для автоматической перерисовки
    return Consumer<MessageProvider>(
      builder: (context, messageProvider, child) {
        // Обновляем локальный chat из allChats при изменении MessageProvider
        for (var updatedChat in allChats) {
          if (updatedChat.id == chat.id) {
            chat = updatedChat;
            break;
          }
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
            leading: BackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
                : InkWell(
                    onTap: () {
                      if (chat.members.length == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => UserPage(
                              userName:
                                  chat.members.first == config.server.userGlobal.userName
                                  ? chat.members.last
                                  : chat.members.first,
                            ),
                          ),
                        );
                      } else {
                        List<MemberDto> members = [];
                        for(String m in chat.members)
                        {
members.add(MemberDto(memberUsername: m, memberImage: ''));
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CreateChatPage(chat: Chat(ChatDto(authorId: chat.authorId.toString(), id: chat.id, name: chat.name, messages: [], members: members, chatImage: chat.chatImage, image: [])),),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        if (chat.chatImage == '') const Icon(Icons.people),
                        if (chat.chatImage != '')
                          CircleAvatar(
                            backgroundImage: NetworkImage(chat.chatImage),
                          ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        Text(chat.name, style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
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
              if (!searchActive)
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
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: false,
                    itemCount: chat.messages.length,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          children: [
                            if (chat.messages[index].authorId == config.server.userGlobal.id)
                              InkWell(
                                onTap: selectedMessages.isNotEmpty
                                    ? () {
                                        setState(() {
                                          if (!selectedMessages.contains(
                                            chat.messages[index],
                                          )) {
                                            selectedMessages.add(
                                              chat.messages[index],
                                            );
                                          } else {
                                            selectedMessages.remove(
                                              chat.messages[index],
                                            );
                                          }
                                        });
                                      }
                                    : null,
                                onLongPress: () {
                                  setState(() {
                                    selectedMessages.add(chat.messages[index]);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 4,
                                    right: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        selectedMessages.contains(
                                          chat.messages[index].id,
                                        )
                                        ? config.accentColor
                                        : Colors.black87,
                                    borderRadius: BorderRadius.circular(5),
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
                                    message: chat.messages[index],
                                  ),
                                ),
                              ),
                            if (chat.messages[index].authorId != config.server.userGlobal.id)
                              InkWell(
                                onTap: selectedMessages.isNotEmpty
                                    ? () {
                                        setState(() {
                                          if (!selectedMessages.contains(
                                            chat.messages[index],
                                          )) {
                                            selectedMessages.add(
                                              chat.messages[index],
                                            );
                                          } else {
                                            selectedMessages.remove(
                                              chat.messages[index],
                                            );
                                          }
                                        });
                                      }
                                    : null,
                                onLongPress: () {
                                  setState(() {
                                    selectedMessages.add(chat.messages[index]);
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
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: MessageOne(
                                    message: chat.messages[index],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (selectedMessages.isEmpty &&
                    !recordAudio &&
                    !stickerPick &&
                    !replyMessage)
                  Container(
                    height:
                        MediaQuery.of(context).size.height * 0.16 -
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
                              height:
                                  MediaQuery.of(context).size.height * 0.15 -
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
                                    ? Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.delete_forever,
                                        size: 40,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 6),
                          height:
                              MediaQuery.of(context).size.height * 0.15 -
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
                                  message = value;
                                },
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height:
                              MediaQuery.of(context).size.height * 0.15 -
                              kToolbarHeight,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: uploadData
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
                        ),
                      ],
                    ),
                  ),
                if (selectedMessages.isEmpty && recordAudio)
                  Container(
                    height:
                        MediaQuery.of(context).size.height * 0.16 -
                        kToolbarHeight,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: AudioRecorderPage(chatId: chat.id, updateParent: updateParent),
                  ),
                if (selectedMessages.isNotEmpty && !replyMessage)
MessageMenu(context, updateParent: updateParent, activateReplyMessage: activateReplyMessage, removeMessages: removeMessages,),
                if (stickerPick)

SendSticker(
                                    updateParent: updateParent,
                                    chatId: allChats[selectChat].id,
                                  ),
                if (replyMessage)
SendReaction(
                                    updateParent: updateParent,
                                    messageId: selectedMessages.first.id,
                                  ),
              ],
            ),
          ),
          floatingActionButton: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.42,
                ),
              ),
              if (bottomButtonView)
                FloatingActionButton(
                  onPressed: () {
                    scrollDown();
                  },
                  backgroundColor: Colors.black54,
                  child: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
      },
    );
  }
}
