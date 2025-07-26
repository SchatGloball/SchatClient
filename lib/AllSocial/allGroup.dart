import 'package:flutter/material.dart';
import 'package:schat2/AllSocial/GroupScreen.dart';
import 'package:schat2/AllSocial/coolGroupScreen.dart';
import 'package:schat2/generated/social.pb.dart';
import '../eventStore.dart';
import 'createGroup.dart';
import '../DataClasses/Group.dart';

class AllGroupsPage extends StatefulWidget {
  const AllGroupsPage({super.key});

  @override
  State<AllGroupsPage> createState() => _AllGroupsPage();
}

class _AllGroupsPage extends State<AllGroupsPage> {
  @override
  void initState() {
    super.initState();
    downloadGroups();
  }

  //late StreamSubscription streamSubscription;

  @override
  void dispose() {
    super.dispose();
    groups.clear();
  }

  downloadGroups() async {
    groups.clear();
    ListChannelsDto c = await socialApi.getUserGroups(0);
    for (ChannelDto channel in c.channels) {
      groups.add(Group(channel));
    }
    setState(() {});
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
              },
            ),
            backgroundColor: config.accentColor,
            automaticallyImplyLeading: false,
            title: Text(
              'Schat social',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              IconButton(
                onPressed: () async {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const CoolGroupsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.emoji_people_sharp),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {},
            child: ListView.separated(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            GroupPage(indexGroup: index),
                      ),
                    );
                    setState(() {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.93,
                    padding: const EdgeInsets.all(5),
                    color: Colors.black26,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (groups[index].image.isEmpty)
                              CircleAvatar(
                                child: Icon(
                                  color: config.accentColor,
                                  Icons.group,
                                ),
                              ),
                            if (groups[index].image.isNotEmpty)
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  groups[index].image,
                                ),
                              ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                            ),
                            Text(
                              groups[index].name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Text(
                          groups[index].topik.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black54,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CreateGroupPage(
                    group: Group(
                      ChannelDto(
                        id: -1,
                        name: '',
                        authorId: userGlobal.id,
                        posts: [],
                        channelImage: '',
                        members: [],
                        image: [],
                        tags: [],
                        topik: [],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Icon(Icons.add_box_outlined, color: config.accentColor),
          ),
        ),
      ],
    );
  }
}
