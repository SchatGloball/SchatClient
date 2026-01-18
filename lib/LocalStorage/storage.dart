import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:schat2/DataClasses/server.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

import '../env.dart';
import '../eventStore.dart';

class LocalStorage {
  late StoreRef<int, Map<String, Object?>> store;
  dynamic factory = 0;
  dynamic db = 0;

  setTokens(String refreshToken) async {
Map config = await getAppConfig();
  List<Map<String, dynamic>> servers = [];
  
  for (Map s in config['servers']) {
    // Создаем копию Map, чтобы избежать проблем с неизменяемостью
    Map<String, dynamic> serverCopy = Map<String, dynamic>.from(s);
    
    if (serverCopy['select'] == true) {
      // Модифицируем копию, а не оригинальный объект
      serverCopy['refreshToken'] = refreshToken;
    }
    
    servers.add(serverCopy);
  }
  
  await store.add(db, <String, Object?>{
    'language': config['language'],
    'notification': config['notification'],
    'accent_color': config['accent_color'],
    'servers': servers,
    'localPass': config['localPass'],
    'sendHotkeyCtrl': config['sendHotkeyCtrl'],
    'backgroundAsset': config['backgroundAsset'],
    'isDarkTheme': config['isDarkTheme']
  });
  }

  Future<Map> getAppConfig() async {
    List<int> listKeys = await store.findKeys(db);
    if (listKeys.isEmpty) {
      await initDataBase(config.isWeb, true);
      listKeys = await store.findKeys(db);
    }
    Map<String, Object?> value =
        await store.record(listKeys.last).get(db) ?? {};
    if (value.keys.isEmpty) {
     
      //Map n = await getAppConfig();
  
    } else {
      if (listKeys.length > 40) {
        await store.drop(db);
        await store.add(db, <String, Object?>{
          'language': value['language'],
          'notification': value['notification'],
          'accent_color': value['accent_color'],
          'servers': value['servers'],
          'localPass': value['localPass'],
          'sendHotkeyCtrl': value['sendHotkeyCtrl'],
          'backgroundAsset': value['backgroundAsset'],
          'isDarkTheme': value['isDarkTheme']
        });
      }
    }
    return value;
  }

 

  setConfig() async {
    final Map configOld = await getAppConfig();
    await store.add(db, <String, Object?>{
      'language': config.language,
      'notification': config.notification,
      'accent_color': config.accentColor.toARGB32(),
      'servers': configOld['servers'],
      'localPass': config.localPass,
      'sendHotkeyCtrl': config.sendHotkeyCtrl,
      'backgroundAsset': config.backgroundAsset,
      'isDarkTheme': config.isDarkTheme
    });
  }


  Future<bool> setServer(BackendServer server) async {
    Map configOld = await getAppConfig();
    await store.drop(db);
    List newServers = [];
    for (Map s in configOld['servers']) {
      newServers.add(s);
    }
    newServers.add({'name': server.name, 'address':server.address, 'port': server.port, 'refreshToken': server.refreshToken, 'select': server.name==config.server.name?true:false});
    await store.add(db, <String, Object?>{
      'language': configOld['language'],
      'notification': configOld['notification'],
      'accent_color': configOld['accent_color'],
      'servers': newServers,
      'localPass': configOld['localPass'],
      'sendHotkeyCtrl': configOld['sendHotkeyCtrl'],
      'backgroundAsset': configOld['backgroundAsset'],
      'isDarkTheme': configOld['isDarkTheme']
    });
    return true;
  }
Future<bool> editServer(BackendServer newServer, String oldName) async {
    Map configOld = await getAppConfig();
    await store.drop(db);
    List<Map> newServers = [];
    for (Map s in configOld['servers']) {
      if(oldName == s['name'])
      {
newServers.add({'name': newServer.name, 'address':newServer.address, 'port': newServer.port, 'refreshToken':  s['refreshToken'], 'select': oldName==config.server.name?true:false});
      }
      else{
newServers.add(s);
      }
      
    }
    await store.add(db, <String, Object?>{
      'language': configOld['language'],
      'notification': configOld['notification'],
      'accent_color': configOld['accent_color'],
      'servers': newServers,
      'localPass': configOld['localPass'],
      'sendHotkeyCtrl': configOld['sendHotkeyCtrl'],
      'backgroundAsset': configOld['backgroundAsset'],
      'isDarkTheme': configOld['isDarkTheme']
    });
    return true;
  }


  Future<bool> deleteServer(BackendServer server) async {
    Map configOld = await getAppConfig();
    await store.drop(db);
    List<Map> newServers = [];   
    for (Map s in configOld['servers']) {
      if(server.name != s['name'])
      {newServers.add(s);}
    }
    await store.add(db, <String, Object?>{
      'language': configOld['language'],
      'notification': configOld['notification'],
      'accent_color': configOld['accent_color'],
      'servers': newServers,
      'localPass': configOld['localPass'],
      'sendHotkeyCtrl': configOld['sendHotkeyCtrl'],
      'backgroundAsset': configOld['backgroundAsset'],
      'isDarkTheme': configOld['isDarkTheme']
    });
    return true;
  }

  Future<bool> selectServer(String name) async {
    Map configOld = await getAppConfig();
    await store.drop(db);
    List<Map> newServers = [];
    for (Map s in configOld['servers']) {
      if(s['name']==config.server.name)
      {
        newServers.add({'name': s['name'], 'address':s['address'], 'port': s['port'], 'refreshToken': s['refreshToken'], 'select': false});
      }
      if(s['name']== name)
      {
        newServers.add({'name': s['name'], 'address':s['address'], 'port': s['port'], 'refreshToken': s['refreshToken'], 'select': true});
      }
      if(s['name']!=config.server.name&&s['name']!= name)
      {newServers.add(s);}
    }
    await store.add(db, <String, Object?>{
      'language': configOld['language'],
      'notification': configOld['notification'],
      'accent_color': configOld['accent_color'],
      'servers': newServers,
      'localPass': configOld['localPass'],
      'sendHotkeyCtrl': configOld['sendHotkeyCtrl'],
      'backgroundAsset': configOld['backgroundAsset'],
      'isDarkTheme': configOld['isDarkTheme']
    });
    return true;
  }

  initDataBase(bool isWeb, bool resetConfig) async {
    if (isWeb) {
      store = intMapStoreFactory.store();
      factory = databaseFactoryWeb;
      db = await factory.openDatabase('schat_local_storage');

      List<int> listKeys = await store.findKeys(db);
      if (listKeys.isEmpty||resetConfig) {
        await store.add(db, <String, Object?>{
          'language': 'ru',
          'notification': true,
          'accent_color': 3038072426,
          'servers': [
            {'name': 'defaultServer', 'address':Env.defaultServer, 'port': Env.defaultWebPort, 'refreshToken': '', 'select': true}
          ],
          'localPass': '',
          'sendHotkeyCtrl': true,
          'backgroundAsset': 'background1.jpg',
          'isDarkTheme': true
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
      if (listKeys.isEmpty||resetConfig) {
        await store.add(db, <String, Object?>{
          'language': 'ru',
          'notification': true,
          'accent_color': 3038072426,
          'servers': [
            {'name': 'defaultServer', 'address':Env.defaultServer, 'port': Env.defaultPort, 'refreshToken': '', 'select': true}
          ],
          'localPass': '',
          'sendHotkeyCtrl': true,
          'backgroundAsset': 'background1.jpg',
          'isDarkTheme': true
        });
      }
    }
  }
}
