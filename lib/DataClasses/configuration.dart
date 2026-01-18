import 'package:flutter/material.dart';
import 'package:schat2/DataClasses/server.dart';





class Configuration {
  Configuration(Map conf, {required bool isWeb})
  {
    
language = conf['language']??'en';
    notification = conf['notification']??true;
    accentColor = Color(conf['accent_color'] ?? 3960673141);
    sendHotkeyCtrl = conf['sendHotkeyCtrl'] ?? true;
    localPass = conf['localPass'] ?? '';
    backgroundAsset = conf['backgroundAsset'] ?? 'background1.jpg';
    this.isWeb = isWeb;
    for(Map s in conf['servers'])
    {
      if(s['select'])
      {
    server = BackendServer(s['port'], s['address'], s['refreshToken'],s['name'], isWeb: isWeb);
      }
    }
   isDarkTheme = conf['isDarkTheme']??true;
  }
late BackendServer server;
 late String language;
 late bool notification;
  late bool sendHotkeyCtrl;
  bool isWeb = false;
  bool widescreen = false;
  Color accentColor = Color(3960673141);
  bool isDarkTheme = true;
  String localPass = '';
  String backgroundAsset = 'background1.jpg';
  final double containerRadius = 8;
final double maxHeightWidescreen = 0.4;
// setThemeMode(bool isDark)async
// {
// isDarkTheme = isDark;
// await storage.setConfig();

// }
// setAccentColor(Color accent_color, ThemeProvider provider) async {
//   accentColor = accent_color;
//   await storage.setConfig();
  
// print(accent_color.toARGB32());
//    provider.updateAccentColor(accentColor);
// }

  // String configToJSON() {
  //   return jsonEncode({
  //     'sendHotkeyCtrl': sendHotkeyCtrl,
  //     'language': language,
  //     'notification': notification,
  //     'accentColor': accentColor.value
  //   });
  // }
  //
  Map stickersAssets = {
    0: [10001, 10002, 10003,10004, 10005],
    1: [20001, 20002, 20003,20004, 20005, 20006, 20007, 20008, 20009, 20010, 20011, 20012]
  };
  List<String> backgroundList = ['background1.jpg', 'background2.jpg', 'background3.jpg', 'background4.jpg', 'background5.jpg', 'background6.jpg', 'background7.jpg', 'background8.jpg', 'background9.jpg', 'background10.jpg',];
}
