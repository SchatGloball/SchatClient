import 'package:flutter/material.dart';
import 'package:schat2/AllSocial/allGroup.dart';
import 'package:schat2/CreateChatService/createChat.dart';
import 'package:schat2/SettingsService/settingsScreen.dart';
import 'package:schat2/generated/chats.pb.dart';
import 'package:schat2/user/UserGeneral.dart';
import '../DataClasses/chatData.dart';
import '../eventStore.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback updateParent;
  const ActionButton({super.key, required this.updateParent});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          
          heroTag: "btn4",
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const AllGroupsPage(),
              ),
            );
          },
          child: Icon(Icons.group_outlined),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        FloatingActionButton(
         
          heroTag: "btn3",
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => UserGeneralPage(),
              ),
            );
          },
          child: Icon(Icons.person),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        FloatingActionButton(
          
          heroTag: "btn2",
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const SettingsPage(),
              ),
            );
            updateParent();
          },
          child: Icon(Icons.settings),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        FloatingActionButton(
          
          heroTag: "btn1",
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
      ],
    );
  }
}
