import 'package:flutter/material.dart';
import 'package:schat2/AllChatService/chatCard.dart';
import '../DataClasses/chatData.dart';
import '../eventStore.dart';

class ForwardedMessagePage extends StatefulWidget {
 late Chat forwardedChat;
  ForwardedMessagePage({super.key, required this.forwardedChat});

  @override
  State<ForwardedMessagePage> createState() => _ForwardedMessagePage();
}

class  _ForwardedMessagePage extends State<ForwardedMessagePage> {

  @override
   initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


forwardMessages(Chat chatFinal)async
{
  await config.server.chatApi.forwardMessage(chatFinal, widget.forwardedChat.messages);
Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return 
    LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
                double size = screenSize.width > screenSize.height?config.maxHeightWidescreen:0.95;
                
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
              color: Colors.white54,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            automaticallyImplyLeading: false,
            title:  Text('Schat', style: Theme.of(context).textTheme.titleLarge,),
            ),
          body:
          Center(child: SizedBox(
            width: MediaQuery.of(context).size.width * size,
            
            child:  ListView.builder(
                itemCount: allChats.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: InkWell(
                      child: ChatCard(index),
                      onTap: () async {
                      forwardMessages(allChats[index]);
                      },
                    ),
                  );
                },
              ),
            ))
          
          
          ,


        )
      ],
    );
                });


    
  }
}
