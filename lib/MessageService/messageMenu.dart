import 'package:flutter/material.dart';
import 'package:schat2/DataClasses/chatData.dart';
import 'package:schat2/MessageService/forwardedMessage.dart';
import 'package:schat2/generated/chats.pb.dart';
import '../eventStore.dart';

class MessageMenu extends StatelessWidget {
  final VoidCallback updateParent;
  final VoidCallback activateReplyMessage;
  final VoidCallback removeMessages;
  const MessageMenu(BuildContext context, {super.key, required this.updateParent, required this.activateReplyMessage, required this.removeMessages});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                            updateParent();
                                          },
                                          iconSize: 40,
                                          icon: Icon(
                                            Icons.highlight_remove,
                                          ),
                                        ),
                                        Center(child: Text(selectedMessages.length.toString(), style: Theme.of(context).textTheme.titleSmall,), ),
                                        if (selectedMessages.length == 1)
                                          IconButton(
                                            onPressed: () {
                                              activateReplyMessage();
                                            },
                                            icon: Icon(
                                              Icons.reply,
                                            ),
                                            iconSize: 40,
                                          ),
                                        
                                        IconButton(
                                          onPressed: () async {
                                          removeMessages();
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                          ),
                                          iconSize: 40,
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
                                           updateParent();
                                          },
                                          icon: Icon(
                                            Icons.arrow_circle_right_outlined,
                                          ),
                                          iconSize: 40,
                                        ),
                                      ],
                                    ),
                                  );
  }
}