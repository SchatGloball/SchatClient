import '../eventStore.dart';

class User {
  User(int idUser, String nameUser, String imageAvatarUser) {
    id = idUser;
    userName = nameUser;
    imageAvatar = imageAvatarUser;
  }
  late final int id;
  late final String userName;
  String imageAvatar = '';
  String accessToken = '';
  String refreshToken = '';

  void setTokens(accessTokenNew, refreshTokenNew) async{
    accessToken = accessTokenNew;
    refreshToken = refreshTokenNew;
    if (accessToken != '' && accessToken != '') {
     await storage.setTokens(accessToken, refreshToken);
    }
  }

  void clearTokens() {
    refreshToken = '';
    accessToken = '';
      storage.setTokens(accessToken, refreshToken);
  }
  getTokens()async
  {
    Map tokens = await storage.getAppConfig();
    accessToken = tokens['accessToken'];
    refreshToken = tokens['refreshToken'];
  }

  bool get dialogToUser {
    for (var element in allChats) {
      if (element.members.length == 2 && element.members.contains(userName)) {
        return true;
      }
    }
    return false;
  }
}
