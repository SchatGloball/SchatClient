import 'package:schat2/DataClasses/Comment.dart';

import '../env.dart';
import '../generated/social.pb.dart';

class PostData {
  PostData(PostDto post) {
    id = post.id;
    body = post.body;
    authorId = post.authorId;
    authorName = post.authorName;
    channelId = post.channelId;

    for (var element in post.content) {
      bool document = true;
      if (Env.image.contains(element.split('?X').first.split('.').last)) {
        imageContent.add(element);
        document = false;
      }
      if (Env.audio.contains(element.split('?X').first.split('.').last)) {
        audioContent.add(element);
        document = false;
      }
      if (Env.video.contains(element.split('?X').first.split('.').last)) {
        videoContent.add(element);
        document = false;
      }
      if (document) {
        documentContent.add(element);
      }
    }

    RegExp regExp = RegExp(
        r'http[s]?:\/\/(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');
    Iterable<Match> matches = regExp.allMatches(body);

    for (Match match in matches) {
      linksInBody.add(match.group(0)!);
    }

  topik = post.topik;
    stickerContent = post.stickerContent;
    post.datePost = post.datePost.replaceAll("T", " ");
    datePost = parseDate(post.datePost);
  
    date = DateTime(
        int.parse(post.datePost.split(' ')[0].split('-')[0]),
        int.parse(post.datePost.split(' ')[0].split('-')[1]),
        int.parse(post.datePost.split(' ')[0].split('-')[2]),
        int.parse(post.datePost.split(' ')[1].split(':')[0]),
        int.parse(post.datePost.split(' ')[1].split(':')[1]),
        int.parse(
            post.datePost.split(' ')[1].split(':')[2].split('.')[0]));
    for(CommentDto comment in post.comments)
      {
        comments.add(CommentData(comment));
      }
      likes.addAll(post.likes);
  }

  late final int id;
  late String body;
  late final int authorId;
  late final int channelId;
  List<String> likes = [];
  List<String> tags = [];
  List<String> linksInBody = [];
  List<String> audioContent = [];
  List<String> videoContent = [];
  List<String> imageContent = [];
  List<String> documentContent = [];
  List<CommentData> comments = [];
  late int stickerContent;
  late final DateTime date;
  late final String datePost;
  late final String authorName;
  late final String topik;

  parseDate(String dateTime) {
 
    String year = dateTime.split(' ')[0].split('-')[0];
    String mouth = dateTime.split(' ')[0].split('-')[1];
    String day = dateTime.split(' ')[0].split('-')[2];
    String hour = dateTime.split(' ')[1].split(':')[0];
    String minute = dateTime.split(' ')[1].split(':')[1];
    String second = dateTime.split(' ')[1].split(':')[2].split('.')[0];
    String timeMessage = '$year.$mouth.$day $hour:$minute:$second';
   return timeMessage;
   
  }
}
