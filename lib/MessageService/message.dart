import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:schat2/MessageService/reactionWidget.dart';
import 'package:schat2/MessageService/videoPlayer.dart';
import 'package:schat2/MessageService/webPreview.dart';
import 'package:uuid/uuid.dart';
import '../DataClasses/chatData.dart';
import '../DataClasses/file.dart';
import '../allWidgets/acceptDialog.dart';
import '../allWidgets/infoDialog.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart';
import '../imageViewer.dart';
import '../localization/localization.dart';
import '../user/userScreen.dart';
import 'OneMessageWidget.dart';
import 'audioPlayer.dart';
import 'audioRecorder.dart';
import 'editGroupChat.dart';
import 'forwardedMessage.dart';

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

  late StreamSubscription<dynamic> streamEvent;
  bool stickerPick = false;
  List<Message> selectedMessages = [];
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
    listenChat();
  }

  bool checkRemoveMessages() {
    for (Message m in selectedMessages) {
      if (m.authorId != userGlobal.id) {
        return false;
      }
    }
    return true;
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
  }

  @override
  void dispose() {
    fieldText.dispose();
    streamEvent.cancel();
    searchMessageSelect = 0;
    searchMessage.clear();
    searchActive = false;
    super.dispose();
  }

  scrollDown() async {
    if (chat.messages.isNotEmpty) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
  }

  pickFile() async {
    filesPick = await pickFiles();
    setState(() {});
  }

  downloadChat(int offset) async {
    Map messages = await chatApi.viewMessagesChat(chat.id, offset);
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
      Map send = await chatApi.sendMessages(chat.id, message, filesPick);
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
        authorId: userGlobal.id,
        authorName: userGlobal.userName,
        messageId: selectedMessages.first.id,
        stickerContent: 0,
        dateReaction: DateTime.now().toString(),
      ),
    );
    Map send = await chatApi.sendReaction(req);
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

  listenChat() async {
    streamEvent = chatApi.eventController.stream.listen(
      (item) => updateMessagesChat(item),
    );
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
    Map res = await chatApi.removeChat(chat.id);
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
    List<MessageDto> res = await chatApi.searchMessage(searchKey, chat);
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
            leading: BackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
                : InkWell(
                    onTap: () {
                      if (chat.members.length == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => UserPage(
                              userName:
                                  chat.members.first == userGlobal.userName
                                  ? chat.members.last
                                  : chat.members.first,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditGroupPage(groupChat: chat),
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
                        Text(chat.name),
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
                            if (chat.messages[index].authorId == userGlobal.id)
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
                                      ], // Gradient from https://learnui.design/tools/gradient-generator.html
                                      tileMode: TileMode.mirror,
                                    ),
                                  ),
                                  child: MessageOne(
                                    message: chat.messages[index],
                                  ),
                                ),
                              ),
                            if (chat.messages[index].authorId != userGlobal.id)
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
                                      ], // Gradient from https://learnui.design/tools/gradient-generator.html
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
                                        color: config.accentColor,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.delete_forever,
                                        color: config.accentColor,
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
                                    color: config.accentColor,
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
                    child: AudioRecorderPage(chatId: chat.id),
                  ),
                if (selectedMessages.isNotEmpty && !replyMessage)
                  Container(
                    height:
                        MediaQuery.of(context).size.height * 0.16 -
                        kToolbarHeight,
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Text(
                            '${selectedMessages.length}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
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
                        if (checkRemoveMessages())
                          IconButton(
                            onPressed: () async {
                              for (var item in selectedMessages) {
                                Map res = await chatApi.removeMessage(item);
                                if (res.keys.first == 'Error') {
                                  infoDialog(context, res['Error']);
                                } else {
                                  setState(() {
                                    chat.messages.removeWhere(
                                      (element) => element == item,
                                    );
                                  });
                                }
                              }
                              setState(() {
                                selectedMessages.clear();
                              });
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: config.accentColor,
                            ),
                            iconSize: 40,
                          ),
                        IconButton(
                          onPressed: () async {
                            List<MessageDto> m = [];
                            for (Message mes in selectedMessages) {
                              m.add(
                                MessageDto(
                                  id: mes.id,
                                  body: mes.body,
                                  authorId: mes.authorId,
                                  authorName: mes.authorName,
                                  delivered: mes.delivered,
                                  content: [],
                                  stickerContent: 0,
                                  dateMessage: DateTime.now().toString(),
                                  reaction: [],
                                  forwarded: mes.forwarded,
                                  originalAuthor: mes.originalAuthor,
                                  originalDate: DateTime.now().toString(),
                                ),
                              );
                            }
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ForwardedMessagePage(
                                      forwardedChat: Chat(
                                        ChatDto(
                                          messages: m,
                                          id: chat.id,
                                          name: chat.name,
                                          authorId: chat.authorId.toString(),
                                          chatImage: chat.chatImage,
                                          members: [],
                                        ),
                                      ),
                                    ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: config.accentColor,
                          ),
                          iconSize: 40,
                        ),
                        if (selectedMessages.length == 1)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                replyMessage = true;
                              });
                            },
                            icon: Icon(Icons.reply, color: config.accentColor),
                            iconSize: 40,
                          ),
                      ],
                    ),
                  ),
                if (stickerPick)
                  Container(
                    height:
                        MediaQuery.of(context).size.height * 0.16 -
                        kToolbarHeight,
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                          height: MediaQuery.of(context).size.height * 0.16,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                stickerPick = false;
                              });
                            },
                            child: Icon(
                              Icons.highlight_remove,
                              color: config.accentColor,
                              size: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                          height: MediaQuery.of(context).size.height * 0.16,
                          child: InkWell(
                            onTap: () {
                              if (selectStickerPack + 1 <
                                  config.stickersAssets.length) {
                                setState(() {
                                  ++selectStickerPack;
                                });
                              } else {
                                setState(() {
                                  selectStickerPack = 0;
                                });
                              }
                            },
                            child: Lottie.asset(
                              'assets/${config.stickersAssets[selectStickerPack].first}.json',
                            ),
                          ),
                        ),
                        SizedBox(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.78,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: config
                                  .stickersAssets[selectStickerPack]
                                  .length,
                              itemBuilder: (context, indexTwo) {
                                return InkWell(
                                  onTap: () async {
                                    Map send = await chatApi.sendMessages(
                                      chat.id,
                                      'sticker${config.stickersAssets[selectStickerPack][indexTwo]}',
                                      [],
                                      config
                                          .stickersAssets[selectStickerPack][indexTwo],
                                    );
                                    if (send.keys.first == 'Error') {
                                      infoDialog(context, send['Error']);
                                    } else {
                                      setState(() {
                                        stickerPick = false;
                                      });
                                    }
                                  },
                                  child: Lottie.asset(
                                    'assets/${config.stickersAssets[selectStickerPack][indexTwo]}.json',
                                  ),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        1, // количество виджетов в ряду
                                    childAspectRatio: 5 / 5,
                                  ),
                              // запрещает прокрутку списка
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (replyMessage)
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
                        IconButton(
                          onPressed: () {
                            setState(() {
                              selectedMessages.clear();
                              replyMessage = false;
                            });
                          },
                          icon: Icon(
                            Icons.clear_outlined,
                            color: config.accentColor,
                          ),
                          iconSize: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 6),
                          height:
                              MediaQuery.of(context).size.height * 0.16 -
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
                          child: InkWell(
                            onTap: () async {
                              sendReaction();
                              fieldText.clear();
                            },
                            child: Icon(
                              Icons.send,
                              size: 40,
                              color: config.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    color: config.accentColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
