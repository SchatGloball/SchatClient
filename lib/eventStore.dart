import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:protobuf/protobuf.dart';
import 'package:restart_app/restart_app.dart';
import 'package:schat2/APIService/socialService.dart';
import 'package:schat2/DataClasses/file.dart';
import 'package:schat2/soundPlay.dart';

import 'APIService/callService.dart';
import 'APIService/chatService.dart';
import 'APIService/userService.dart';
import 'DataClasses/Group.dart';
import 'DataClasses/UserData.dart';
import 'DataClasses/chatData.dart';
import 'DataClasses/configuration.dart';
import 'LocalStorage/storage.dart';
import 'Notification/notification.dart';
import 'env.dart';
import 'generated/call.pb.dart' hide UpdateDTO;
import 'generated/chats.pb.dart';

listenEventChat() async {
  chatApi.update();
  callApi.listenCall();
}

LocalStorage storage = LocalStorage();
String activeCall = '';
int selectStickerPack = 0;
NotificationService notification = NotificationService();
late StreamSubscription eventStream;
late StreamSubscription<UpdateDTO> listenServerEvent;
Configuration config = Configuration();
bool uploadData = false;

User userGlobal = User(0, 'name', '');

List<Chat> allChats = [];
List<Group> groups = [];
List<Message> searchMessage = [];
int searchMessageSelect = 0;
bool searchActive = false;
bool recordAudio = false;

PlayerAudio player = PlayerAudio();

UserService userApi = UserService(Env.defaultServer, Env.defaultPort);
ChatService chatApi = ChatService(Env.defaultServer, Env.defaultPort);
CallService callApi = CallService(Env.defaultServer, Env.defaultPort);
SocialService socialApi = SocialService(Env.defaultServer, Env.defaultPort);

connect() async {
  List servers = await storage.getServers();
  config.server = servers.first.split(':').first;
  config.port = int.parse(servers.first.split(':').last);

  userApi.updateApi(config.server, config.port);
  chatApi.updateApi(config.server, config.port);
  callApi.updateApi(config.server, config.port);
  socialApi.updateApi(config.server, config.port);
}

refreshApp() async {
  try {
    allChats.clear();
    Map chatsIsServer = await chatApi.viewAllChat();
    PbList<ChatDto> m = chatsIsServer['chats'];
    for (var e in m) {
      allChats.add(Chat(e));
    }
  } catch (e) {
    print(e);
    Restart.restartApp(
      notificationTitle: 'Restarting App',
      notificationBody: 'Please tap here to open the app again.',
    );
  }
}

pickFiles() async {
  List<FileData> files = [];
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
  );
  if (result != null) {
    if (config.isWeb) {
      for (var element in result.files) {
        files.add(
          FileData(element.path.toString(), element.bytes!, element.name),
        );
      }
    } else {
      for (int i = 0; i < result.files.length; i++) {
        Uint8List fileBytes = await File(
          result.paths[i].toString(),
        ).readAsBytes();
        files.add(
          FileData(result.paths[i].toString(), fileBytes, result.files[i].name),
        );
      }
    }
  } else {
    // User canceled the picker
  }
  return files;
}

refreshTokens() async {
  try {
    Map tokens = await userApi.refreshToken(userGlobal.refreshToken);
    if (tokens.keys.first == 'Error') {
      return false;
    }
    userGlobal.setTokens(tokens['accessToken'], tokens['refreshToken']);
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
