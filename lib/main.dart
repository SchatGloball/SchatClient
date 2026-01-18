import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_localization/flutter_localization.dart';
import 'package:media_kit/media_kit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:schat2/DataClasses/configuration.dart';
import 'package:schat2/WidescreenChat/chatAll.dart';
import 'package:schat2/AllChatService/messageProvider.dart';
import 'package:schat2/theme/themeProvider.dart';
import 'AllChatService/allChat.dart';
import 'AllChatService/backgroundWork.dart';

import 'LoginService/login.dart';
import 'calc.dart';
import 'eventStore.dart';
import 'dart:io';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  // Определяем isWeb до создания config, чтобы избежать циклической зависимости
  bool isWebValue = kIsWeb;
  
  // Запрашиваем разрешения только на Android (не на веб)
  if (!isWebValue) {
    try {
      // ignore: undefined_identifier
      if (Platform.isAndroid) {
        await Permission.storage.request();
        await Permission.notification.request();
        
        // Запрашиваем игнорирование оптимизации батареи для надежной работы фоновых задач
        try {
          bool isIgnoringBatteryOptimizations = await Permission.ignoreBatteryOptimizations.isGranted;
          if (!isIgnoringBatteryOptimizations) {
            await Permission.ignoreBatteryOptimizations.request();
          }
        } catch (e) {
          print('Battery optimization permission request skipped: ${e.toString()}');
        }
        
        startBackground();
      }
    } catch (e) {
      // Если произошла ошибка, просто продолжаем
      print('Permission request skipped: ${e.toString()}');
    }
  }
 
  await storage.initDataBase(isWebValue, false);
  Map configuration = await storage.getAppConfig();
  config = Configuration(configuration, isWeb: isWebValue);
  // FlutterLocalization не поддерживает веб-платформу, инициализируем только для нативных платформ
  if (!isWebValue) {
    try {
      await FlutterLocalization.instance.ensureInitialized();
    } catch (e) {
      print('FlutterLocalization initialization error: ${e.toString()}');
    }
  }

  runApp(
    // Обертываем всё приложение в провайдер
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => MessageProvider(),
        ),
        
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          home: InitialApp(checkLocalPass: true),
          // Используем тему из провайдера
          darkTheme: themeProvider.themeData,
          theme: themeProvider.themeData,
          themeMode: config.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
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
//запуск только после отрисовки виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notification.init();
      userLoginScreen();
    });
  }
bool localPassCheck = true;



   void userLoginScreen() async {
    if(config.localPass.isNotEmpty)
    {
      localPassCheck = false;
      try{
localPassCheck = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CalcButton(),
          ),
        );
      }
      catch(e)
      {
userLoginScreen();
return;
      }
    }

bool checkTokens = await config.server.refreshTokens();
if(checkTokens&&localPassCheck)
{
  goToChat();
}
else
{
  try{
    bool successLogin = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
        if(successLogin)
        {
          goToChat();
        }
        else{
userLoginScreen();
return;
        }
  }
  catch(e)
  {
userLoginScreen();
return;
  }
}
  }

 goToChat() async {
  await config.server.fetchUser();
  
  if (config.widescreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AllChatWidescreenPage(),
      ),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AllChatPage(),
      ),
    );
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


