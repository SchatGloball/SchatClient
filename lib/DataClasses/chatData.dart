import '../env.dart';
import '../eventStore.dart';
import '../generated/chats.pb.dart';

class Chat {
  Chat(ChatDto chat) {
    id = chat.id;
    if (chat.members.length == 2) {
      if (chat.members.first.memberUsername == userGlobal.userName) {
        name = chat.members.last.memberUsername;
      } else {
        name = chat.members.first.memberUsername;
      }
    } else {
      name = chat.name;
    }
    authorId = int.tryParse(chat.authorId) ?? 0;

    chatImage = chat.chatImage;
    if (chatImage == '' && chat.members.length == 2) {
      if (chat.members.first.memberUsername == userGlobal.userName) {
        chatImage = chat.members.last.memberImage;
      } else {
        chatImage = chat.members.first.memberImage;
      }
    }

    for (var element in chat.members) {
      members.add(element.memberUsername);
    }
    for (var element in chat.messages) {
      addMessage(element, false);
    }
  }
  DateTime dateLastMessage = DateTime(2010);
  late final int id;
  late String name;
  late final int authorId;
  late String chatImage;
  List members = [];
  List<Message> messages = [];

  addMessage(MessageDto element, bool startArray) {
    if (element.body != '') {
      if (!startArray) {
        messages.add(Message(element));
      } else {
        if (element.authorId != userGlobal.id) {
          for (var mes in messages) {
            mes.delivered = true;
          }
        }
        messages.insert(0, Message(element));
      }
      if (messages.first.date.isAfter(dateLastMessage)) {
        dateLastMessage = messages.first.date;
      }
    }
  }
}

class Message {
  Message(MessageDto message) {
    id = message.id;
    body = message.body;
    authorId = message.authorId;
    delivered = message.delivered;
    forwarded = message.forwarded;
    originalAuthor = message.originalAuthor;
    message.originalDate = message.originalDate.replaceAll("T", " ");
    originalDate = parseDate(message.originalDate);
    authorName = message.authorName;
    for (ReactionMessageDto element in message.reaction) {
      reactions.add(ReactionMessage(element));
    }

    for (var element in message.content) {
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
      r'http[s]?:\/\/(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+',
    );
    Iterable<Match> matches = regExp.allMatches(body);

    for (Match match in matches) {
      linksInBody.add(match.group(0)!);
    }

    stickerContent = message.stickerContent;
    message.dateMessage = message.dateMessage.replaceAll("T", " ");
    dateMessage = parseDate(message.dateMessage);
    date = DateTime(
      int.tryParse(message.dateMessage.split(' ')[0].split('-')[0]) ?? 20,
      int.parse(message.dateMessage.split(' ')[0].split('-')[1]),
      int.parse(message.dateMessage.split(' ')[0].split('-')[2]),
      int.parse(message.dateMessage.split(' ')[1].split(':')[0]),
      int.parse(message.dateMessage.split(' ')[1].split(':')[1]),
      int.parse(message.dateMessage.split(' ')[1].split(':')[2].split('.')[0]),
    );
  }

  late final int id;
  late String body;
  late final int authorId;
  List<String> linksInBody = [];
  List<String> audioContent = [];
  List<String> videoContent = [];
  List<String> imageContent = [];
  List<String> documentContent = [];
  List<ReactionMessage> reactions = [];
  late int stickerContent;
  late final DateTime date;
  late final String dateMessage;
  late bool delivered;
  late final String authorName;
  late final String originalAuthor;
  late final String originalDate;
  late final bool forwarded;

  parseDate(String dateTime) {
    if (dateTime.isEmpty) {
      return ' ';
    }
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

class ReactionMessage {
  ReactionMessage(ReactionMessageDto r) {
    id = r.id;
    body = r.body;
    authorId = r.authorId;
    authorName = r.authorName;
    messageId = r.messageId;
    sticker = r.stickerContent;
    date = parseDate(r.dateReaction);
  }

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

  late int id;
  late String body;
  late int authorId;
  late String authorName;
  late int sticker;
  late String date;
  late int messageId;
}
