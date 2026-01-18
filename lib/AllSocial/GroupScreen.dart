import 'package:flutter/material.dart';
import 'package:schat2/AllSocial/createGroup.dart';
import 'package:schat2/AllSocial/postWidget.dart';
import 'package:schat2/DataClasses/Topik.dart';
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
  State<GroupPage> createState() => _GroupPage();
}

class _GroupPage extends State<GroupPage> {

 
  @override
  void initState() {
   
    super.initState();
    downloadPosts( groups[widget.indexGroup].topik[selectTopik].name,  groups[widget.indexGroup].topik[selectTopik].posts.length);
  }
int selectTopik = 0;
 
  @override
  void dispose() {
    super.dispose();
  }
  
  downloadPosts(String topik, int offset) async {
    List<PostDto> p = await config.server.socialApi.getChannelPosts(Group(ChannelDto(id: groups[widget.indexGroup].id, topik: [groups[widget.indexGroup].topik[selectTopik].name])), offset);
    for(PostDto post in p)
    {
      groups[widget.indexGroup].topik[selectTopik].posts.add(PostData(post));
    }
    setState(() {

    });
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
         
          appBar: AppBar(
            leading: BackButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            
            automaticallyImplyLeading: false,
            title:  Text('Schat social', style: Theme.of(context).textTheme.titleLarge,),
            actions: [
              if(groups[widget.indexGroup].authorId != config.server.userGlobal.id)
              IconButton(onPressed: ()async{
                ResponseDto res = await config.server.socialApi.addMemberGroup(ChannelDto(id: groups[widget.indexGroup].id));
                if(res.success&&groups[widget.indexGroup].members.contains(config.server.userGlobal.userName))
                {
                  setState(() {
                    groups[widget.indexGroup].members.remove(config.server.userGlobal.userName);
                  });
                  return;
                }
                if(res.success&&!groups[widget.indexGroup].members.contains(config.server.userGlobal.userName))
                {
                  setState(() {
                    groups[widget.indexGroup].members.add(config.server.userGlobal.userName);
                  });
                }
              }, icon: groups[widget.indexGroup].members.contains(config.server.userGlobal.userName)?const Icon(Icons.backspace_outlined) : const Icon(Icons.add_circle_outline)),
              if(groups[widget.indexGroup].authorId == config.server.userGlobal.id)
                IconButton(onPressed: ()async{

                 final id =  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CreateGroupPage(group: groups[widget.indexGroup])));
    if(id.runtimeType!=Null) {
groups.clear();
ListChannelsDto c = await config.server.socialApi.getUserGroups(0);
for(ChannelDto channel in c.channels)
{
  groups.add(Group(channel));
}
setState(() {

});
    }
                }, icon: const Icon(Icons.edit_outlined))
             ],),
          body: 
          Center(child: SizedBox(
            width: MediaQuery.of(context).size.width * size,
            child: Column(
    children: [
      Container(

        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height* 0.2 - kToolbarHeight,
        color: Colors.black26,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(groups[widget.indexGroup].image!='')
              InkWell(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      groups[widget.indexGroup].image),
                  radius: 55,
                ),
                onTap: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ImageViewerPage(
                                image: groups[widget.indexGroup].image,
                              )));
                },
              )
            ,
            if(groups[widget.indexGroup].image=='')
              Icon(Icons.groups, size: 55),
Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
            
                  Text(groups[widget.indexGroup].name, style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2,)
                  ,
                  InkWell(onTap: ()async{
                    await  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => UserListPage(userList: groups[widget.indexGroup].members)));
                  }, child: Text('members ${groups[widget.indexGroup].members.length}', style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis,))
                  
                  ],))
            
          ],
        ),
      ),
      SizedBox(
height: 30,
        child: ListView.builder(
          reverse: false,
          itemCount: groups[widget.indexGroup].topik.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap:
          true, // позволяет списку занимать только необходимое пространство
          itemBuilder:
              (BuildContext context, int index) {
            return InkWell(
              onTap: ()async{
                selectTopik = index;
               await downloadPosts( groups[widget.indexGroup].topik[selectTopik].name,  groups[widget.indexGroup].topik[selectTopik].posts.length);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child:
                  Center(child:  Text(groups[widget.indexGroup].topik[index].name, style: Theme.of(context).textTheme.titleSmall), )
              ,
                color: groups[widget.indexGroup].topik[selectTopik].name==groups[widget.indexGroup].topikList[index] ? config.accentColor : Colors.black26,),
            ); },
        ),
      ),
      Expanded(
        child: RefreshIndicator(
            onRefresh: () async {
            },
            child: ListView.builder(
              itemCount: groups[widget.indexGroup].topik[selectTopik].posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: groups[widget.indexGroup].topik[selectTopik].posts[index]);
              },
            )),
      )
    ],
    ),
          ),)
          ,
          floatingActionButton: groups[widget.indexGroup].authorId==config.server.userGlobal.id? FloatingActionButton(
            onPressed: () async {
            final id =  await  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CreatePostPage(post: PostData(PostDto(id: 0, body: '', authorId: config.server.userGlobal.id, channelId: groups[widget.indexGroup].id, authorName: config.server.userGlobal.userName, data: [], likes: [], content: [], comments: [], datePost: '2025-06-13 15:31:56.050045', tags: [], topik: groups[widget.indexGroup].topik[selectTopik].name, stickerContent: 0)),)));
if(id.runtimeType!=Null)
  {
PostDto post = await config.server.socialApi.getOnePost(id);
setState(() {
  groups[widget.indexGroup].topik[selectTopik].posts.insert(0, PostData(post));
});
  }
            },
            child: Icon(
              Icons.add_box_outlined,
            
            ),
          ):null,
        )
      ],
    ); });
  }
}