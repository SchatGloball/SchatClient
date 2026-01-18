
import 'package:flutter/material.dart';
import 'package:schat2/allWidgets/infoDialog.dart';
import '../DataClasses/Post.dart';
import '../DataClasses/file.dart';
import '../eventStore.dart';
import '../generated/social.pb.dart';
import '../localization/localization.dart';






class CreatePostPage extends StatefulWidget
{
late PostData post;
  CreatePostPage({super.key, required this.post});

  @override
  State<CreatePostPage> createState() => _CreatePostPage(post: post);
}

class _CreatePostPage extends State<CreatePostPage> {

  late PostData post;

  _CreatePostPage({required this.post});
String tags = '';
  @override
  void initState() {
    super.initState();
  }
List<FileData> filesPick = [];
  pickFile() async {
    filesPick = await pickFiles();
    if(filesPick.isEmpty)
      {

      }
    setState(() {

    });
  }


  createPost()async
  {
    if(tags.isNotEmpty)
      {
        post.tags = tags.split(' ');
      }
    try{
      final ResponseDto res = await config.server.socialApi.createPost(post, filesPick);
      if(res.success==true)
        {
          Navigator.pop(context, int.parse(res.message));
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
    LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
                double size = screenSize.width > screenSize.height?config.maxHeightWidescreen:0.95;

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
                  
                  leading: BackButton(
                      color: Colors.white54,
                      onPressed: (){
                        Navigator.of(context).pop();}
                  ),
                  automaticallyImplyLeading: false,
                ),
                
                body:
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height- kToolbarHeight,
                    width: MediaQuery.of(context).size.width * size,
                    padding: const EdgeInsets.all(10),
                    color: Colors.black54,
                    child: Column(
                      children: [
                        Text(Localization
                            .localizationData[config.language]['createPostScreen']['title'],
                            style: Theme.of(context).textTheme.titleMedium
                        ),
                        TextField(
                          onChanged: (String value) {
                           post.body = value;
                          },
                          decoration: InputDecoration(
                            labelText: Localization
                                .localizationData[config.language]['createPostScreen']['body'],
                            labelStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextField(
                          onChanged: (String value) {

                          },
                          decoration: InputDecoration(
                            labelText: Localization
                                .localizationData[config.language]['createPostScreen']['tags'],
                            labelStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(onPressed: (){
                          pickFile();
                        }, icon:  Icon(Icons.image_search_sharp)),
                        ListView.builder(
                          itemCount: filesPick.length,
                          itemBuilder: (context, indexTwo) {
                            return
                              Column(children: [
                                Text(filesPick[indexTwo].name, style: Theme.of(context).textTheme.titleSmall,),
                                IconButton(onPressed: (){setState(() {
                                  filesPick.removeAt(indexTwo);
                                });}, icon: Icon(Icons.delete_forever))
                              ],);

                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.5,
                            padding: const EdgeInsets.only(top: 8),
                            child: ElevatedButton(onPressed:
                                () async {
                              createPost();
                            },
                              child: Text(Localization
                                  .localizationData[config.language]['createChatScreen']['goButton']),
                            )),
                      ],),
                  ),
                )


            )
          ]);});
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
