import 'package:schat2/DataClasses/Post.dart';
import 'package:schat2/DataClasses/Topik.dart';

import '../generated/social.pb.dart';

class Group
{
  Group(ChannelDto c)
  {
id = c.id;
name = c.name;
authorId = c.authorId;
tags = c.tags;
image = c.channelImage;
for(var m in  c.members)
  {
    members.add(m.memberUsername);
  }
  for(var m in  c.topik)
  {
   topik.add(Topik(m));
  }
for(PostDto p in c.posts)
  {
    for(Topik t in topik)
    {
      if(t.name == p.topik)
      {
        t.posts.add(PostData(p));
      }
    }
  }
  }
  late final int id;
  late String name;
  late final int authorId;
  List<String> tags = [];
  List<String> members = [];
  List<Topik> topik = [];
  late String image;

  List<String>  get topikList
  {
    List<String> res = [];
    for(Topik t in topik)
    {
      res.add(t.name);
    }
    return res;
  }
 // Map<String, List> posts = {};
}