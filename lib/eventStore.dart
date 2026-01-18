import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:protobuf/protobuf.dart';
import 'package:restart_app/restart_app.dart';
import 'package:schat2/DataClasses/file.dart';
import 'package:schat2/localization/localization.dart';
import 'package:schat2/soundPlay.dart';
import 'DataClasses/Group.dart';
import 'DataClasses/chatData.dart';
import 'DataClasses/configuration.dart';
import 'LocalStorage/storage.dart';
import 'Notification/notification.dart';
import 'generated/chats.pb.dart';

listenEventChat() async {
  config.server.chatApi.update();
  config.server.callApi.listenCall();
}

  StreamSubscription? streamCallSubscription;
LocalStorage storage = LocalStorage();
String activeCall = '';
int selectStickerPack = 0;
NotificationService notification = NotificationService();
late StreamSubscription eventStream;
late StreamSubscription<UpdateDTO> listenServerEvent;
late Configuration config;
bool uploadData = false;

//User userGlobal = User(0, 'name', '');
final FlutterLocalization localization = FlutterLocalization.instance;
List<Chat> allChats = [];
List<Group> groups = [];
List<Message> searchMessage = [];
int searchMessageSelect = 0;
bool searchActive = false;
bool recordAudio = false;
List<Message> selectedMessages = [];
int selectChat = 0;
int selectChatId = 0;

PlayerAudio player = PlayerAudio();

refreshApp() async {
  try {
    allChats.clear();
   Map chatsIsServer = await config.server.chatApi.viewAllChat();
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

 Future<List<FileData>> pickFiles() async {
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

String getLocalizedString(String key) {
    // Пробуем использовать AppLocale из flutter_localization
    try {
      if (config.language == 'en' && AppLocale.EN.containsKey(key)) {
        return AppLocale.EN[key] as String;
      } else if (config.language == 'ru' && AppLocale.RU.containsKey(key)) {
        return AppLocale.RU[key] as String;
      }
    } catch (e) {
      // Если AppLocale не работает, используем fallback
    }
    // Fallback на старый способ локализации
    return Localization.localizationData[config.language]?['themeSwitcher']?[key] ?? key;
  }