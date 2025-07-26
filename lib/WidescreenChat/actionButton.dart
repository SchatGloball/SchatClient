import 'package:flutter/material.dart';
import 'package:schat2/AllSocial/allGroup.dart';
import 'package:schat2/CreateChatService/createChat.dart';
import 'package:schat2/SettingsService/settingsScreen.dart';
import 'package:schat2/user/UserGeneral.dart';
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
          backgroundColor: Colors.black54,
          heroTag: "btn4",
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const AllGroupsPage(),
              ),
            );
          },
          child: Icon(Icons.group_outlined, color: config.accentColor),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        FloatingActionButton(
          backgroundColor: Colors.black54,
          heroTag: "btn3",
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => UserGeneralPage(),
              ),
            );
          },
          child: Icon(Icons.person, color: config.accentColor),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        FloatingActionButton(
          backgroundColor: Colors.black54,
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
          child: Icon(Icons.settings, color: config.accentColor),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        FloatingActionButton(
          backgroundColor: Colors.black54,
          heroTag: "btn1",
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const CreateChatPage(),
              ),
            );
          },
          child: Icon(Icons.message_rounded, color: config.accentColor),
        ),
      ],
    );
  }
}
