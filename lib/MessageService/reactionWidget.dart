import 'package:flutter/material.dart';
import 'package:schat2/allWidgets/acceptDialog.dart';
import 'package:schat2/allWidgets/infoDialog.dart';
import 'package:schat2/eventStore.dart';
import '../DataClasses/chatData.dart';

class ReactionWidget extends StatefulWidget {

  late Message message;
  ReactionWidget({super.key, required this.message});

  @override
  State<ReactionWidget> createState() => _ReactionWidget();
}

class _ReactionWidget extends State<ReactionWidget> {
  

bool reactionsView = false;


  @override
  void initState() {
    super.initState();
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
    Text('${widget.message.reactions.length} - ${widget.message.reactions.first.body}',
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
                  itemCount: widget.message.reactions.length,
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
                              onLongPress: widget.message.reactions[index].authorId == config.server.userGlobal.id ? ()async{
                               bool check = await  acceptDialog(context, 'Remove?')??false;
                               if(check)
                                 {
                                   try{
                                     String res =  await config.server.chatApi.removeReaction(widget.message.reactions[index]);
                                     if(res=='success')
                                     {
                                       setState(() {
                                         widget.message.reactions.remove(widget.message.reactions[index]);
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
                                  children: [Text('${widget.message.reactions[index].date} ${widget.message.reactions[index].authorName}',
                                      style: Theme.of(context).textTheme.titleSmall ),],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(widget.message.reactions[index].body,
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