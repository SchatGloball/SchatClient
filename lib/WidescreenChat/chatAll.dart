import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:protobuf/protobuf.dart';
import 'package:schat2/AllChatService/allChat.dart';
import 'package:schat2/AllSocial/allGroup.dart';
import 'package:schat2/MessageService/forwardedMessage.dart';
import 'package:schat2/WidescreenChat/actionButton.dart';
import 'package:schat2/WidescreenChat/sendReaction.dart';
import 'package:schat2/WidescreenChat/sendSticker.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:super_hot_key/super_hot_key.dart';
import '../CreateChatService/createChat.dart';
import '../DataClasses/UserData.dart';
import '../DataClasses/chatData.dart';
import '../DataClasses/file.dart';
import '../LoginService/login.dart';
import '../MessageService/OneMessageWidget.dart';
import '../MessageService/audioRecorder.dart';
import '../MessageService/editGroupChat.dart';
import '../MessageService/message.dart';
import '../SettingsService/settingsScreen.dart';
import '../allWidgets/acceptDialog.dart';
import '../allWidgets/infoDialog.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart';
import '../localization/localization.dart';
import '../user/UserGeneral.dart';
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
    registerHotkey();
  }

  bool stickerPick = false;
  int selectChat = 0;
  int selectChatId = 0;
  ScrollController scrollController = ScrollController();
  List<Message> selectedMessages = [];
  List<FileData> filesPick = [];
  String message = '';
  final fieldText = TextEditingController();
  late final HotKey? hotKeySend;
  late final HotKey? hotKeyPaste;
  bool replyMessage = false;

  @override
  void dispose() {
    chatApi.updateEvent.cancel();
    hotKeyPaste!.dispose();
    hotKeySend!.dispose();
    super.dispose();
  }

  registerHotkey() async {
    hotKeySend = await HotKey.create(
      definition: HotKeyDefinition(
        control: true,
        alt: false,
        key: PhysicalKeyboardKey.enter,
        meta: false,
      ),
      onPressed: () {
        sendMessage();
      },
    );

    // hotKeyPaste = await HotKey.create(
    //     definition: HotKeyDefinition(
    //       control: true,
    //       alt: false,
    //       key: PhysicalKeyboardKey.keyV,
    //       meta: false,
    //     ),
    //     onPressed: () {
    //       clipboard();
    //     });
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
      Map send = await chatApi.sendMessages(
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
  }

  downloadChat(int offset) async {
    Map messages = await chatApi.viewMessagesChat(
      allChats[selectChat].id,
      offset,
    );
    setState(() {
      for (var element in messages['chat'].messages ?? []) {
        allChats[selectChat].messages.add(Message(element));
      }
    });
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
    if (allChats.isNotEmpty) {
      initData();
    }
  }

  deleteChat() async {
    final int id = allChats[selectChat].id;
    Map res = await chatApi.removeChat(id);
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
    final int selectChatId = allChats[selectChat].id;
    allChats.sort((b, a) => a.dateLastMessage.compareTo(b.dateLastMessage));
    for (int i = 0; i < allChats.length; i++) {
      if (allChats[i].id == selectChatId) {
        selectChat = i;
      }
    }
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

  clipboard() async {
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return; // Clipboard API is not supported on this platform.
    }
    final reader = await clipboard.read();

    if (reader.canProvide(Formats.htmlText)) {
      final html = await reader.readValue(Formats.htmlText);
      setState(() {
        fieldText.text = html.toString();
      });
    }

    if (reader.canProvide(Formats.plainText)) {
      final String? text = await reader.readValue(Formats.plainText);
      setState(() {
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
    List<MessageDto> res = await chatApi.searchMessage(
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: config.accentColor,
            automaticallyImplyLeading: false,
            title: searchActive
                ? TextField(
                    //controller: _searchController,
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
                    await refreshApp();
                    if (chatApi.eventController.isClosed) {
                      listenEventChat();
                    }
                    downloadChat(allChats[selectChat].messages.length);
                    setState(() {});
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    await chatApi.updateEvent.cancel();
                    allChats.clear();
                    Map chatsIsServer = await chatApi.viewAllChat();
                    PbList<ChatDto> m = chatsIsServer['chats'];
                    for (var e in m) {
                      setState(() {
                        allChats.add(Chat(e));
                      });
                    }
                  },
                  child: ListView.builder(
                    itemCount: allChats.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == selectChat
                                  ? config.accentColor
                                  : Colors.black54,
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
                                          color:
                                              Colors.deepPurpleAccent.shade100,
                                          Icons.person,
                                        ),
                                      ),
                                    if (allChats[index].chatImage.toString() !=
                                            'null' &&
                                        allChats[index].chatImage.toString() !=
                                            '')
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
                                        allChats[index]
                                            .messages
                                            .first
                                            .delivered)
                                      const Icon(
                                        Icons.check_sharp,
                                        color: Colors.white70,
                                      ),
                                    if (allChats[index].messages.isNotEmpty &&
                                        !allChats[index]
                                            .messages
                                            .first
                                            .delivered &&
                                        allChats[index]
                                                .messages
                                                .first
                                                .authorId !=
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
                            if (index == selectChat) {
                              if (allChats[index].members.length == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => UserPage(
                                      userName:
                                          allChats[index].members.first ==
                                              userGlobal.userName
                                          ? allChats[index].members.last
                                          : allChats[index].members.first,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EditGroupPage(
                                          groupChat: allChats[index],
                                        ),
                                  ),
                                );
                              }
                            }
                            deliveredMessage(allChats[index].id);
                            if (allChats[index].messages.isNotEmpty) {
                              if (allChats[index].messages.first.authorId !=
                                  userGlobal.id) {
                                setState(() {
                                  allChats[index].messages.first.delivered =
                                      true;
                                });
                              }
                            }
                            setState(() {
                              selectChat = index;
                              selectChatId = allChats[index].id;
                              initData();
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
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
                                        userGlobal.id)
                                      InkWell(
                                        onLongPress: () {
                                          setState(() {
                                            selectedMessages.add(
                                              allChats[selectChat]
                                                  .messages[index],
                                            );
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
                                        userGlobal.id)
                                      Container(
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
                                          color: config.accentColor,
                                          tooltip:
                                              Localization
                                                  .localizationData[config
                                                  .language]['messageScreen']['paste'],
                                          style: TextButton.styleFrom(
                                            foregroundColor: config.accentColor,
                                          ),
                                          icon: Icon(
                                            Icons.paste,
                                            size: 40,
                                            color: config.accentColor,
                                          ),
                                          onPressed: () {
                                            clipboard();
                                          },
                                        ),
                                        IconButton(
                                          color: config.accentColor,
                                          style: TextButton.styleFrom(
                                            foregroundColor: config.accentColor,
                                          ),
                                          icon: Icon(
                                            Icons.insert_emoticon_sharp,
                                            size: 40,
                                            color: config.accentColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              stickerPick = true;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          color: config.accentColor,
                                          style: TextButton.styleFrom(
                                            foregroundColor: config.accentColor,
                                          ),
                                          icon: filesPick.isEmpty
                                              ? Icon(
                                                  Icons.add_a_photo_outlined,
                                                  size: 40,
                                                  color: config.accentColor,
                                                )
                                              : Icon(
                                                  Icons.delete_forever,
                                                  size: 40,
                                                  color: config.accentColor,
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
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 6,
                                          ),
                                          height:
                                              MediaQuery.of(
                                                    context,
                                                  ).size.height *
                                                  0.16 -
                                              kToolbarHeight,
                                          width: parentWidth / 1.7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
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
                                                  if (value.contains('\n') &&
                                                      !config.sendHotkeyCtrl) {
                                                    sendMessage();
                                                  }
                                                  message = value;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
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
                                                  color: config.accentColor,
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
                                      chatId: allChats[selectChat].id,
                                    ),
                                  ),
                                if (selectedMessages.isNotEmpty &&
                                    !replyMessage)
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.15 -
                                        kToolbarHeight,
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedMessages.clear();
                                            });
                                          },
                                          iconSize: 40,
                                          icon: Icon(
                                            Icons.highlight_remove,
                                            color: config.accentColor,
                                          ),
                                        ),
                                        if (selectedMessages.length == 1)
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                replyMessage = true;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.reply,
                                              color: config.accentColor,
                                            ),
                                            iconSize: 40,
                                          ),
                                        IconButton(
                                          onPressed: () async {
                                            for (var item in selectedMessages) {
                                              Map res = await chatApi
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
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                          ),
                                          iconSize: 40,
                                          color: config.accentColor,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            List<MessageDto> m = [];
                                            for (Message mes
                                                in selectedMessages) {
                                              m.add(
                                                MessageDto(
                                                  id: mes.id,
                                                  body: mes.body,
                                                  authorId: mes.authorId,
                                                  authorName: mes.authorName,
                                                  delivered: mes.delivered,
                                                  content: [],
                                                  stickerContent: 0,
                                                  dateMessage: DateTime.now()
                                                      .toString(),
                                                  reaction: [],
                                                  forwarded: mes.forwarded,
                                                  originalAuthor:
                                                      mes.originalAuthor,
                                                  originalDate: DateTime.now()
                                                      .toString(),
                                                ),
                                              );
                                            }
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (
                                                      BuildContext context,
                                                    ) => ForwardedMessagePage(
                                                      forwardedChat: Chat(
                                                        ChatDto(
                                                          messages: m,
                                                          id: allChats[selectChat]
                                                              .id,
                                                          name:
                                                              allChats[selectChat]
                                                                  .name,
                                                          authorId:
                                                              allChats[selectChat]
                                                                  .authorId
                                                                  .toString(),
                                                          chatImage:
                                                              allChats[selectChat]
                                                                  .chatImage,
                                                          members: [],
                                                        ),
                                                      ),
                                                    ),
                                              ),
                                            );
                                            setState(() {
                                              selectedMessages.clear();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: config.accentColor,
                                          ),
                                          iconSize: 40,
                                        ),
                                      ],
                                    ),
                                  ),
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
            ],
          ),
          floatingActionButton: ActionButton(updateParent: updateParent),
        ),
      ],
    );
  }
}
