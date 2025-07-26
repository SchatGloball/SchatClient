import 'dart:io';
import 'package:workmanager/workmanager.dart';
import '../APIService/chatService.dart';
import '../Notification/notification.dart';
import '../eventStore.dart';
import '../localization/localization.dart';

const simplePeriodicTask =
    "be.tramckrijte.workmanagerExample.simplePeriodicTask";
const simplePeriodic1HourTask =
    'be.tramckrijte.workmanagerExample.simplePeriodic1HourTask';


@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simplePeriodic1HourTask:
        NotificationService notification = NotificationService();
        notification.init();
        ChatService chatApi = ChatService(config.server, config.port);
        userGlobal.getTokens();
        final bool n = await chatApi.notificationNewMessage(userGlobal.accessToken);
        if (n) {
          notification.newEvent(
              'Schat',
              Localization.localizationData[config.language]['notification']
                  ['newMessage']);
        }
        // print("$simplePeriodic1HourTask was executed");
        // print('+++++++++++++++++++++++++++++++++++++++++++++++++++++');
        break;
    }
    return Future.value(true);
  });
}

startBackground() async {
  if (!config.isWeb) {
    if (Platform.isAndroid) {
      await Workmanager().initialize(
        callbackDispatcher,
      );

      Workmanager().registerPeriodicTask(
          simplePeriodicTask, simplePeriodic1HourTask,
          frequency: const Duration(seconds: 901));
    } else {
      backGroundWorkDesktop();
    }
  }
}

backGroundWorkDesktop() async {
  print('object');
  // final bool n = await chatApi.notificationNewMessage(userGlobal.accessToken);
  // if (n) {
  //   notification.newEvent(
  //       'Schat',
  //       Localization.localizationData[config.language]['notification']
  //           ['newMessage']);
  // }
  // return Future.delayed(
  //     const Duration(seconds: 180), () => backGroundWorkDesktop());
}
