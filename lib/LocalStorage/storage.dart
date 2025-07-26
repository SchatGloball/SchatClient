import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sembast_web/sembast_web.dart';

import '../env.dart';
import '../eventStore.dart';

class LocalStorage {
  late StoreRef<int, Map<String, Object?>> store;
  dynamic factory = 0;
  dynamic db = 0;

  setTokens(String accessToken, String refreshToken) async {
    Map config = await getAppConfig();
    await store.add(db, <String, Object?>{
      'language': config['language'],
      'notification': config['notification'],
      'accent_color': config['accent_color'],
      'servers': config['servers'],
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'localPass': config['localPass'],
      'sendHotkeyCtrl': config['sendHotkeyCtrl'],
      'backgroundAsset': config['backgroundAsset'],
    });
  }

  Future<Map> getAppConfig() async {
    List<int> listKeys = await store.findKeys(db);
    if (listKeys.isEmpty) {
      await initDataBase();
      listKeys = await store.findKeys(db);
    }
    Map<String, Object?> value =
        await store.record(listKeys.last).get(db) ?? {};
    if (value.keys.isEmpty) {
      print('Error: ошибка бд!!!!!!!!!!!!!!!!!');
      print(listKeys);
      Map n = await getAppConfig();
      print(n);
    } else {
      if (listKeys.length > 40) {
        await store.drop(db);
        await store.add(db, <String, Object?>{
          'language': value['language'],
          'notification': value['notification'],
          'accent_color': value['accent_color'],
          'servers': value['servers'],
          'accessToken': value['accessToken'],
          'refreshToken': value['refreshToken'],
          'localPass': value['localPass'],
          'sendHotkeyCtrl': value['sendHotkeyCtrl'],
          'backgroundAsset': value['backgroundAsset'],
        });
      }
    }
    return value;
  }

  removeUserData() async {
    Map config = await getAppConfig();
    await store.add(db, <String, Object?>{
      'language': config['language'],
      'notification': config['notification'],
      'accent_color': config['accent_color'],
      'servers': config['servers'],
      'accessToken': '',
      'refreshToken': '',
      'localPass': config['localPass'],
      'sendHotkeyCtrl': config['sendHotkeyCtrl'],
      'backgroundAsset': config['backgroundAsset'],
    });
  }

  setConfig() async {
    Map configOld = await getAppConfig();
    await store.add(db, <String, Object?>{
      'language': config.language,
      'notification': config.notification,
      'accent_color': config.accentColor.value,
      'servers': configOld['servers'],
      'accessToken': configOld['accessToken'],
      'refreshToken': configOld['refreshToken'],
      'localPass': config.localPass,
      'sendHotkeyCtrl': config.sendHotkeyCtrl,
      'backgroundAsset': config.backgroundAsset,
    });
  }

  Future<List> getServers() async {
    Map config = await getAppConfig();
    List servers = config['servers'];
    return servers;
  }

  Future<List> setServer(String server) async {
    Map configOld = await getAppConfig();
    await store.drop(db);
    List newServers = [];
    for (String s in configOld['servers']) {
      newServers.add(s);
    }
    newServers.add(server);
    await store.add(db, <String, Object?>{
      'language': configOld['language'],
      'notification': configOld['notification'],
      'accent_color': configOld['accent_color'],
      'servers': newServers,
      'accessToken': configOld['accessToken'],
      'refreshToken': configOld['refreshToken'],
      'localPass': configOld['localPass'],
      'sendHotkeyCtrl': configOld['sendHotkeyCtrl'],
      'backgroundAsset': configOld['backgroundAsset'],
    });
    return newServers;
  }

  Future<List> deleteServer(int index) async {
    Map configOld = await getAppConfig();
    await store.drop(db);
    List newServers = configOld['servers'];
    newServers.removeAt(index);
    await store.add(db, <String, Object?>{
      'language': configOld['language'],
      'notification': configOld['notification'],
      'accent_color': configOld['accent_color'],
      'servers': newServers,
      'accessToken': configOld['accessToken'],
      'refreshToken': configOld['refreshToken'],
      'localPass': configOld['localPass'],
      'sendHotkeyCtrl': configOld['sendHotkeyCtrl'],
      'backgroundAsset': configOld['backgroundAsset'],
    });
    return newServers;
  }

  Future<List> selectServer(int index) async {
    Map configOld = await getAppConfig();
    await store.drop(db);
    List newServers = [];
    for (String s in configOld['servers']) {
      newServers.add(s);
    }
    String buff = newServers[index];
    newServers.removeAt(index);
    newServers.insert(0, buff);
    await store.add(db, <String, Object?>{
      'language': configOld['language'],
      'notification': configOld['notification'],
      'accent_color': configOld['accent_color'],
      'servers': newServers,
      'accessToken': configOld['accessToken'],
      'refreshToken': configOld['refreshToken'],
      'localPass': configOld['localPass'],
      'sendHotkeyCtrl': configOld['sendHotkeyCtrl'],
      'backgroundAsset': configOld['backgroundAsset'],
    });
    return newServers;
  }

  initDataBase() async {
    if (config.isWeb) {
      store = intMapStoreFactory.store();
      factory = databaseFactoryWeb;
      db = await factory.openDatabase('schat_local_storage');

      List<int> listKeys = await store.findKeys(db);
      if (listKeys.isEmpty) {
        await store.add(db, <String, Object?>{
          'language': 'ru',
          'notification': true,
          'accent_color': 3960673141,
          'servers': ['${Env.defaultServer}:${Env.defaultWebPort}'],
          'accessToken': '',
          'refreshToken': '',
          'localPass': '',
          'sendHotkeyCtrl': true,
          'backgroundAsset': 'background1.jpg',
        });
      }
    } else {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      db = await databaseFactoryIo.openDatabase(
        '${appDocumentsDir.path}/schat_local_storage',
      );
      store = intMapStoreFactory.store();
      List<int> listKeys = await store.findKeys(db);
      if (listKeys.isEmpty) {
        await store.add(db, <String, Object?>{
          'language': 'ru',
          'notification': true,
          'accent_color': 3960673141,
          'servers': ['${Env.defaultServer}:${Env.defaultPort}'],
          'accessToken': '',
          'refreshToken': '',
          'localPass': '',
          'sendHotkeyCtrl': true,
          'backgroundAsset': 'background1.jpg',
        });
      }
    }
  }
}
