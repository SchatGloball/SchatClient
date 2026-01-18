import '../eventStore.dart';

class User {
  User(int idUser, String nameUser, String imageAvatarUser, bool isBotUser) {
    id = idUser;
    userName = nameUser;
    imageAvatar = imageAvatarUser;
    isBot = isBotUser;
  }
  late final int id;
  late final String userName;
  late bool isBot;
  String imageAvatar = '';


  bool get dialogToUser {
    for (var element in allChats) {
      if (element.members.length == 2 && element.members.contains(userName)) {
        return true;
      }
    }
    return false;
  }
}
