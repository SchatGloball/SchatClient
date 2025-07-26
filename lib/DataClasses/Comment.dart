import '../env.dart';
import '../generated/social.pb.dart';

class CommentData {
  CommentData(CommentDto comment) {
    id = comment.id;
    body = comment.body;
    authorId = comment.authorId;
    authorName = comment.authorName;

    for (var element in comment.content) {
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

    stickerContent = comment.stickerContent;
    comment.dateComment = comment.dateComment.replaceAll("T", " ");
    dateComment = parseDate(comment.dateComment);

    date = DateTime(
        int.parse(comment.dateComment.split(' ')[0].split('-')[0]),
        int.parse(comment.dateComment.split(' ')[0].split('-')[1]),
        int.parse(comment.dateComment.split(' ')[0].split('-')[2]),
        int.parse(comment.dateComment.split(' ')[1].split(':')[0]),
        int.parse(comment.dateComment.split(' ')[1].split(':')[1]),
        int.parse(
            comment.dateComment.split(' ')[1].split(':')[2].split('.')[0]));
  }

  late final int id;
  late String body;
  late final int authorId;
  late final String authorName;
  List<String> likes = [];
  List<String> linksInBody = [];
  List<String> audioContent = [];
  List<String> videoContent = [];
  List<String> imageContent = [];
  List<String> documentContent = [];
  late int stickerContent;
  late final DateTime date;
  late final String dateComment;


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
