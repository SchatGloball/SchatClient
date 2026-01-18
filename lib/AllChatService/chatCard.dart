import 'package:flutter/material.dart';
import 'package:schat2/eventStore.dart';

// ignore: must_be_immutable
class ChatCard extends StatelessWidget {
late int index;

ChatCard(int i, {super.key})
{
index = i;
}

  @override
  Widget build(BuildContext context) {
    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index==selectChat&&config.widescreen? config.accentColor: Colors.black54,
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
                                    style:  Theme.of(context).textTheme.titleSmall,
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
                                      config.server.userGlobal.id)
                                      Icon(Icons.info_outline_rounded, color: config.accentColor,)
                            ],
                          ),
                        ],
                      ),
                    );
  }
}