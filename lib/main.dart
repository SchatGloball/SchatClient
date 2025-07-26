import 'dart:io';
import 'package:media_kit/media_kit.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:schat2/WidescreenChat/chatAll.dart';
import 'package:schat2/appTheme.dart';

import 'AllChatService/allChat.dart';
import 'AllChatService/backgroundWork.dart';
import 'DataClasses/UserData.dart';
import 'LoginService/login.dart';
import 'calc.dart';
import 'eventStore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  try {
    if (Platform.isAndroid) {
      await Permission.storage.request();
      await Permission.notification.request();
      startBackground();
    }
    if (Platform.isLinux || Platform.isWindows) {
      // await hotKeySystem.unregisterAll();
    }
  } catch (e) {
    config.isWeb = true;
  }
  await storage.initDataBase();
  Map configuration = await storage.getAppConfig();
  print(configuration);
  config.addConfig(configuration);
  await connect();

  runApp(
    MaterialApp(
      home: InitialApp(checkLocalPass: true),
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
    ),
  );

  // runApp(MaterialApp(
  //   home: TestPage(),
  //   darkTheme: darkTheme,
  //   themeMode: ThemeMode.dark,
  // ));
  // await storage.initDataBase();
  // await storage.getAppConfig();
  // final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  // print(appDocumentsDir.path);
}

class RoutingManager {
  refreshToken() async {
    try {
      await userGlobal.getTokens();
      if (userGlobal.refreshToken == '') {
        return false;
      } else {
        // await connect();
        Map tokens = await userApi.refreshToken(userGlobal.refreshToken);
        print(tokens);
        userGlobal.setTokens(tokens['accessToken'], tokens['refreshToken']);
        if (tokens.keys.first == 'Error') {
          userGlobal.clearTokens();
          return false;
        } else {
          final Map u = await userApi.fetchUser();
          userGlobal = User(
            u['user'].id,
            u['user'].username,
            u['user'].imageAvatar,
          );
          userGlobal.setTokens(tokens['accessToken'], tokens['refreshToken']);
          return true;
        }
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

class InitialApp extends StatefulWidget {
  late bool checkLocalPass;
  InitialApp({super.key, required this.checkLocalPass});

  @override
  State<InitialApp> createState() =>
      _InitialApp(checkLocalPass: checkLocalPass);
}

class _InitialApp extends State<InitialApp> {
  late bool checkLocalPass;
  _InitialApp({required this.checkLocalPass});

  @override
  void initState() {
    super.initState();
    userLoginScreen();
    notification.init();
  }

  userLoginScreen() async {
    bool check = await RoutingManager().refreshToken();
    if (config.localPass != '' && checkLocalPass) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CalcButton()),
      );
      return;
    }
    if (!check) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      if (config.widescreen == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AllChatWidescreenPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AllChatPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      config.widescreen = true;
    } else {
      config.widescreen = false;
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Lottie.asset('assets/loader.json')],
      ),
    );
  }
}

// class TestPage extends StatefulWidget {
//   TestPage({super.key});
//   @override
//   State<TestPage> createState() => _TestPage();
// }
// class _TestPage extends State<TestPage> with TickerProviderStateMixin {
//   @override
//   void initState() {
//    permission();
//   }
//   permission()async
//   { PermissionStatus m = await Permission.photos.request();
//   print(m);
//   }
//   @override
//   void dispose() {
//         super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       LayoutBuilder(
//         builder: (context, constraints) {
//           return Scaffold(
//             body: Text('data'),
//           );
//     });}
// }
