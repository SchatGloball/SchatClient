import 'package:flutter/material.dart';
import 'package:schat2/DataClasses/chatData.dart';
import 'package:schat2/DataClasses/file.dart';
import 'package:schat2/generated/chats.pb.dart';
import '../eventStore.dart';

class SendReaction extends StatelessWidget {
  String message = '';
  List<FileData> filesPick = [];
  sendReaction() async {
    if (message == '') {
      filesPick.clear();
    }
    ReactionMessage req = ReactionMessage(
      ReactionMessageDto(
        id: 0,
        body: message,
        authorId: userGlobal.id,
        authorName: userGlobal.userName,
        messageId: messageId,
        stickerContent: 0,
        dateReaction: DateTime.now().toString(),
      ),
    );
    Map send = await chatApi.sendReaction(req);
    if (send.keys.first == 'Error') {
      //  infoDialog(context, send['Error']);
    } else {
      message = '';
      filesPick.clear();
      updateParent();
    }
  }

  final int messageId;
  final VoidCallback updateParent;
  SendReaction({
    super.key,
    required this.updateParent,
    required this.messageId,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16 - kToolbarHeight,
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
              updateParent();
            },
            icon: Icon(Icons.clear_outlined, color: config.accentColor),
            iconSize: 40,
          ),
          Container(
            padding: const EdgeInsets.only(left: 6),
            height: MediaQuery.of(context).size.height * 0.16 - kToolbarHeight,
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  style: Theme.of(context).textTheme.titleLarge,
                  cursorColor: config.accentColor,
                  //controller: fieldText,
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
          InkWell(
            onTap: () async {
              sendReaction();
            },
            child: Icon(Icons.send, size: 40, color: config.accentColor),
          ),
        ],
      ),
    );
  }
}
