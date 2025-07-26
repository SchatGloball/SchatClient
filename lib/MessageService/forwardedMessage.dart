import 'package:flutter/material.dart';
import '../DataClasses/chatData.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart';
import '../localization/localization.dart';


class ForwardedMessagePage extends StatefulWidget {
 late Chat forwardedChat;
  ForwardedMessagePage({super.key, required this.forwardedChat});

  @override
  State<ForwardedMessagePage> createState() => _ForwardedMessagePage(forwardedChat: forwardedChat);
}

class  _ForwardedMessagePage extends State<ForwardedMessagePage> {
  late Chat forwardedChat;
  _ForwardedMessagePage({required this.forwardedChat});

  @override
   initState() {
    super.initState();
  }


  @override
  void dispose() {
    chatApi.updateEvent.cancel();
    if (!config.widescreen) {
      eventStream.cancel();
    }
    super.dispose();
  }


forwardMessages(Chat chatFinal)async
{
  await chatApi.forwardMessage(chatFinal, forwardedChat.messages);
Navigator.pop(context);
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
            automaticallyImplyLeading: false,
            title:  Text('Schat', style: Theme.of(context).textTheme.titleLarge,),
            ),
          body: ListView.builder(
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
                                          Icons.person),
                                    ),
                                  if (allChats[index].chatImage.toString() !=
                                      'null' &&
                                      allChats[index].chatImage.toString() !=
                                          '')
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          allChats[index].chatImage.toString()),
                                    ),
                                  const Padding(padding: EdgeInsets.all(12)),
                                  Text(allChats[index].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(padding: EdgeInsets.all(20)),
                                  if (allChats[index].messages.isNotEmpty)
                                    Expanded(
                                      child: Text(
                                        '${allChats[index]
                                            .messages
                                            .first
                                            .authorName}: ${allChats[index].messages.first.body}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  if (allChats[index].messages.isNotEmpty &&
                                      allChats[index].messages.first.delivered)
                                    const Icon(Icons.check_sharp,
                                        color: Colors.white70),
                                  if (allChats[index].messages.isNotEmpty &&
                                      !allChats[index]
                                          .messages
                                          .first
                                          .delivered &&
                                      allChats[index].messages.first.authorId !=
                                          userGlobal.id)
                                    Text(
                                        Localization.localizationData[
                                        config.language]
                                        ['allChatScreen']['newMessage'] + '  ',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),

                                ],
                              ),
                            ],
                          )),
                      onTap: () async {
                      forwardMessages(allChats[index]);
                      },
                    ),
                  );
                },
              ),


        )
      ],
    );
  }
}
