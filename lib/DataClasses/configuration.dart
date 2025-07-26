import 'package:flutter/material.dart';


import '../env.dart';

class Configuration {
  String language = 'en';
  bool notification = true;
  bool sendHotkeyCtrl = true;
  bool isWeb = false;
  bool widescreen = false;
  Color accentColor = Color(3960673141);
  String localPass = '';
  String server = Env.defaultServer;
  int port = Env.defaultPort;
  String backgroundAsset = 'background1.jpg';

  addConfig(Map config ) {
    language = config['language'];
    notification = config['notification'];
    accentColor = Color(config['accent_color'] ?? 3960673141);
    sendHotkeyCtrl = config['sendHotkeyCtrl'] ?? true;
    localPass = config['localPass'] ?? '';
    backgroundAsset = config['backgroundAsset'] ?? 'background1.jpg';
  }


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
