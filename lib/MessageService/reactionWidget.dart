import 'package:flutter/material.dart';
import 'package:schat2/allWidgets/acceptDialog.dart';
import 'package:schat2/allWidgets/infoDialog.dart';
import 'package:schat2/eventStore.dart';
import '../DataClasses/chatData.dart';

class ReactionWidget extends StatefulWidget {

  late Message message;
  ReactionWidget({super.key, required this.message});

  @override
  State<ReactionWidget> createState() => _ReactionWidget(message: message);
}

class _ReactionWidget extends State<ReactionWidget> {
  late Message message;

  _ReactionWidget({required this.message});
bool reactionsView = false;


  @override
  void initState() {
    super.initState();
    checkUpdate();
  }

  checkUpdate()async
  {
    eventStream = chatApi.eventController.stream.listen((item) async {
     if(item.chat.messages.isNotEmpty)
       {
         if(item.chat.messages.first.reaction.isNotEmpty&&item.chat.messages.first.id==message.id)
           {
             List<int> reactionsId = [];
             for(ReactionMessage r in message.reactions)
               {
                 reactionsId.add(r.id);
               }
             if(!reactionsId.contains(item.chat.messages.first.reaction.last.id))
               {
                 message.reactions.add(ReactionMessage(item.chat.messages.first.reaction.last));
                 setState(() {
                 });
               }

           }
       }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(children: [IconButton(onPressed: ()
          {setState(() {
            reactionsView = !reactionsView;
          });
          },
              icon: const Icon(Icons.undo_sharp)) ,

    Expanded(
    child:
    Text('${message.reactions.length} - ${message.reactions.first.body}',
      style: const TextStyle(
          color: Colors.white, fontSize: 15),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
    )
            ,],)
          ,
          if(reactionsView)
            ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap:
                  true,
                  itemCount: message.reactions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.black45,
                        ),
                        child:
                            InkWell(
                              onLongPress: message.reactions[index].authorId == userGlobal.id ? ()async{
                               bool check = await  acceptDialog(context, 'Remove?')??false;
                               if(check)
                                 {
                                   try{
                                     String res =  await chatApi.removeReaction(message.reactions[index]);
                                     if(res=='success')
                                     {
                                       setState(() {
                                         message.reactions.remove(message.reactions[index]);
                                       });
                                     }
                                   }
                                   catch(e)
                                {
                                  infoDialog(context, e.toString());
                                }
                                 }
                              }: null,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [Text('${message.reactions[index].date} ${message.reactions[index].authorName}',
                                      style: Theme.of(context).textTheme.titleSmall ),],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(message.reactions[index].body,
                                        style: Theme.of(context).textTheme.titleSmall)
                                  ],)
                              ],),
                            )

                    );
                  },
                )
         ],
      ),
    );
  }
}