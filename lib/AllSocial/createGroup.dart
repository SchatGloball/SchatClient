
import 'package:flutter/material.dart';
import 'package:schat2/DataClasses/Topik.dart';
import 'package:schat2/allWidgets/infoDialog.dart';
import '../DataClasses/Group.dart';
import '../DataClasses/file.dart';
import '../eventStore.dart';
import '../localization/localization.dart';
import '../user/userScreen.dart';
import '../generated/social.pbgrpc.dart';





class CreateGroupPage extends StatefulWidget
{
  late Group group;
  CreateGroupPage({super.key, required this.group});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPage(group: group);
}

class _CreateGroupPage extends State<CreateGroupPage> {
  late Group group;
  _CreateGroupPage({required this.group});
  @override
  void initState() {
    super.initState();
    if(group.id!=-1)
      {
        initEditGroup();
      }
  }
 FileData filePick = FileData('', [], '');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController topiksController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  pickFile() async {
    try{
       List f = await pickFiles();
       if(f.first.isImg)
         {
           filePick = f.first;
         }
       else
         {
           infoDialog(context, 'Error type file');
         }
    }
    catch(e)
    {
      infoDialog(context, e.toString());
    }
    setState(() {

    });
  }

 String topikString = '';
  String tags = '';


  initEditGroup()
  {
    for(String t in group.topikList)
   {
    topikString = '$topikString $t';
   }
    for(String t in group.tags)
    {
      tags = '$tags $t';
    }

    nameController.text = group.name;
    topiksController.text = topikString;
    tagsController.text = tags;
    setState(() {

    });
  }

  createGroup()async
  {
    if(topikString.isNotEmpty)
    {
      final RegExp pattern = RegExp(r'\.|,');
      topikString =  topikString.replaceAll(pattern, '');
      for(String t in topikString.split(' '))
      {
        group.topik.add(Topik(t));
      }
    }
    if(tags.isNotEmpty)
      {
        final RegExp pattern = RegExp(r'\.|,');
        tags =  tags.replaceAll(pattern, '');
        group.tags = tags.split(' ');
      }
    try{
      late ResponseDto res;
      if(group.id!=-1)
        {
          res = await config.server.socialApi.editGroup(group, filePick);
        }
      else
        {
         res = await config.server.socialApi.createGroup(group, filePick);
        }

      if(res.success)
      {

        Navigator.pop(context);
      }
    }
    catch(e)
    {
      infoDialog(context, e.toString());
    }
  }




  @override
  Widget build(BuildContext context) {
    return
      Stack(
          children: [
            Image.asset(
              'assets/${config.backgroundAsset}',
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              fit: BoxFit.cover,
            ),
            Scaffold(
                appBar: AppBar(
                  backgroundColor: config.accentColor,
                  leading: BackButton(
                      color: Colors.white54,
                      onPressed: (){
                        Navigator.of(context).pop();}
                  ),
                  automaticallyImplyLeading: false,
                ),
                backgroundColor: Colors.transparent,
                body:
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.95,
                    width: MediaQuery.of(context).size.width*0.95,
                    padding: const EdgeInsets.all(10),
                    color: Colors.black54,
                    child: Column(
                      children: [
                        Text('Новая группа',
                            style: Theme.of(context).textTheme.titleMedium
                        ),
                        TextField(
                          controller: nameController,
                          onChanged: (String value) {
                            group.name = value;
                            setState(() {

                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextField(
                          controller: topiksController,
                          onChanged: (String value) {
                            topikString = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Topiks',
                            labelStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextField(
                          controller: tagsController,
                          onChanged: (String value) {
tags = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Теги',
                            labelStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 10)),
                        if(filePick.data.isEmpty)
                        IconButton(onPressed: (){
                          pickFile();
                        }, icon:  Icon(Icons.image_search_sharp, color: config.accentColor,)),
                        if(filePick.data.isNotEmpty)
                          InkWell(
                            onTap: (){
                              setState(() {
                                filePick = FileData('', [], '');
                              });
                            },
                            child: SizedBox(
                              height: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [Image.memory(filePick.int8List),  Icon(Icons.delete_forever, color: config.accentColor, size: 100,)],),),
                          ),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.5,
                            padding: const EdgeInsets.only(top: 8),
                            child: ElevatedButton(onPressed: group.name.length>3 ?
                                () async {
                              createGroup();
                            }:null,
                              child: Text(Localization
                                  .localizationData[config.language]['createChatScreen']['goButton'],),
                            )),
                      ],),
                  ),
                )


            )
          ]);
  }
  showMyDialog(BuildContext context, text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              text,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
