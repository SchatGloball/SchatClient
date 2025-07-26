import 'package:flutter/material.dart';
import 'package:schat2/AllSocial/createGroup.dart';
import 'package:schat2/AllSocial/postWidget.dart';
import 'package:schat2/generated/social.pb.dart';
import '../DataClasses/Post.dart';
import '../eventStore.dart';
import '../DataClasses/Group.dart';
import '../imageViewer.dart';
import 'UserListScreen.dart';
import 'createPost.dart';



class GroupPage extends StatefulWidget {
  late int indexGroup;
  GroupPage({super.key, required this.indexGroup});
  @override
  State<GroupPage> createState() => _GroupPage(indexGroup: indexGroup);
}

class _GroupPage extends State<GroupPage> {

  late int indexGroup;
  _GroupPage({required this.indexGroup});
  @override
  void initState() {
    super.initState();
    downloadPosts(selectTopik,  groups[indexGroup].posts[selectTopik]!.length);
  }
String selectTopik = 'general';
  //late StreamSubscription streamSubscription;

  @override
  void dispose() {
    super.dispose();
  }
  
  downloadPosts(String topik, int offset) async {
    List<PostDto> p = await socialApi.getChannelPosts(Group(ChannelDto(id: groups[indexGroup].id, topik: [selectTopik])), offset);
    for(PostDto post in p)
    {
      groups[indexGroup].posts[topik]!.add(PostData(post));
    }
    setState(() {

    });
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
            leading: BackButton(
                color: Colors.white54,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            backgroundColor: config.accentColor,
            automaticallyImplyLeading: false,
            title:  Text('Schat social', style: Theme.of(context).textTheme.titleLarge,),
            actions: [
              if(groups[indexGroup].authorId != userGlobal.id)
              IconButton(onPressed: ()async{
                ResponseDto res = await socialApi.addMemberGroup(ChannelDto(id: groups[indexGroup].id));
                if(res.success&&groups[indexGroup].members.contains(userGlobal.userName))
                {
                  setState(() {
                    groups[indexGroup].members.remove(userGlobal.userName);
                  });
                  return;
                }
                if(res.success&&!groups[indexGroup].members.contains(userGlobal.userName))
                {
                  setState(() {
                    groups[indexGroup].members.add(userGlobal.userName);
                  });
                }
              }, icon: groups[indexGroup].members.contains(userGlobal.userName)?const Icon(Icons.backspace_outlined) : const Icon(Icons.add_circle_outline)),
              if(groups[indexGroup].authorId == userGlobal.id)
                IconButton(onPressed: ()async{

                 final id =  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CreateGroupPage(group: groups[indexGroup])));
    if(id.runtimeType!=Null) {
groups.clear();
ListChannelsDto c = await socialApi.getUserGroups(0);
for(ChannelDto channel in c.channels)
{
  groups.add(Group(channel));
}
setState(() {

});
    }
                }, icon: const Icon(Icons.edit_outlined))
             ],),
          body: Column(
    children: [
      Container(

        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height* 0.2 - kToolbarHeight,
        color: Colors.black26,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(groups[indexGroup].image!='')
              InkWell(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      groups[indexGroup].image),
                  radius: 55,
                ),
                onTap: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ImageViewerPage(
                                image: groups[indexGroup].image,
                              )));
                },
              )
            ,
            if(groups[indexGroup].image=='')
              Icon(Icons.groups, size: 55, color: config.accentColor,),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text(groups[indexGroup].name, style: Theme.of(context).textTheme.titleMedium,),
                  InkWell(onTap: ()async{
                    await  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => UserListPage(userList: groups[indexGroup].members)));
                  }, child: Text('members ${groups[indexGroup].members.length}', style: Theme.of(context).textTheme.titleMedium))
                  ],)
          ],
        ),
      ),
      Expanded(

        child: GridView.builder(
          reverse: true,
          itemCount: groups[indexGroup].topik.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            4, // количество виджетов в ряду
            childAspectRatio: 3,
          ),
          shrinkWrap:
          true, // позволяет списку занимать только необходимое пространство
          itemBuilder:
              (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                selectTopik = groups[indexGroup].topik[index];
                downloadPosts(selectTopik, groups[indexGroup].posts[selectTopik]!.length);
              },
              child: Container(padding: EdgeInsets.all(3), child: Container(child:
                  Center(child:  Text(groups[indexGroup].topik[index], style: Theme.of(context).textTheme.titleSmall))
              ,
                color: selectTopik==groups[indexGroup].topik[index] ? config.accentColor : Colors.black26,)),
            ); },
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height* 0.7 - kToolbarHeight,
        child: RefreshIndicator(
            onRefresh: () async {
            },
            child: ListView.builder(
              itemCount: groups[indexGroup].posts[selectTopik]!.length,
              itemBuilder: (context, index) {
                return PostWidget(post: groups[indexGroup].posts[selectTopik]![index]);
              },
            )),
      )
    ],
    ),
          floatingActionButton: groups[indexGroup].authorId==userGlobal.id? FloatingActionButton(
            backgroundColor: Colors.black54,
            onPressed: () async {
            final id =  await  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CreatePostPage(post: PostData(PostDto(id: 0, body: '', authorId: userGlobal.id, channelId: groups[indexGroup].id, authorName: userGlobal.userName, data: [], likes: [], content: [], comments: [], datePost: '2025-06-13 15:31:56.050045', tags: [], topik: selectTopik, stickerContent: 0)),)));
if(id.runtimeType!=Null)
  {
PostDto post = await socialApi.getOnePost(id);
setState(() {
  groups[indexGroup].posts[post.topik]!.insert(0, PostData(post));
});
  }
            },
            child: Icon(
              Icons.add_box_outlined,
              color: config.accentColor,
            ),
          ):null,
        )
      ],
    );
  }
}