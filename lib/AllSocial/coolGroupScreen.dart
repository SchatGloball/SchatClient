
import 'package:flutter/material.dart';
import 'package:schat2/AllSocial/GroupScreen.dart';
import 'package:schat2/generated/social.pb.dart';
import '../eventStore.dart';
import 'createGroup.dart';
import '../DataClasses/Group.dart';



class CoolGroupsPage extends StatefulWidget {
  const CoolGroupsPage({super.key});

  @override
  State<CoolGroupsPage> createState() => _CoolGroupsPage();
}

class _CoolGroupsPage extends State<CoolGroupsPage> {
  @override
  void initState() {
    super.initState();
    downloadGroups();
  }


  @override
  void dispose() {
    super.dispose();
    groups.clear();
  }



  downloadGroups() async {
    ListChannelsDto c = await config.server.socialApi.getCoolGroups();
    for(ChannelDto channel in c.channels)
    {
      groups.add(Group(channel));
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
              IconButton(onPressed: ()async{

              }, icon: const Icon(Icons.search)),],),
          body: RefreshIndicator(
              onRefresh: () async {
              },
              child: ListView.separated(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: ()async{await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => GroupPage(indexGroup: index,)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.93,
                        padding: const EdgeInsets.all(5),
                        color: Colors.black26,
                        child: Column(
                          children: [Row(
                            children: [
                              if(groups[index].image.isEmpty)
                                CircleAvatar(
                                  child: Icon(
                                      color: config.accentColor,
                                      Icons.group),
                                ),
                              if(groups[index].image.isNotEmpty)
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      groups[index].image),
                                ),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                              Text(groups[index].name,
                                  maxLines: 1, // Ограничиваем одной строкой
                                  overflow: TextOverflow.ellipsis, // Добавляем многоточие
                                  style: Theme.of(context).textTheme.titleMedium)
                            ],
                          ),
                            Text(groups[index].topik.toString(), style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                      )
                  ) ;
                }, separatorBuilder: (BuildContext context, int index) {return const Padding(padding: EdgeInsets.symmetric(vertical: 3)); },
              )),
        )
      ],
    );
  }
}