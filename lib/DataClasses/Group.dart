import '../generated/social.pb.dart';
import 'Post.dart';

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
topik = c.topik;
for(PostDto p in c.posts)
  {
   // posts.add(PostData(p));
  }
for(String t in c.topik)
{
  posts[t] = [];
}
  }
  late final int id;
  late String name;
  late final int authorId;
  //List<PostData> posts = [];
  List<String> tags = [];
  List<String> members = [];
  List<String> topik = [];
  late String image;
  Map<String, List> posts = {};
}