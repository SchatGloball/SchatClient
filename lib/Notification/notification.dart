import 'dart:io';
import 'package:local_notifier/local_notifier.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('icon');

  NotificationService() {
    //init();
  }

  init() async {
    if (Platform.isWindows || Platform.isLinux) {
      await localNotifier.setup(
        appName: 'Schat',
        shortcutPolicy: ShortcutPolicy.requireCreate,
      );
      notification.onShow = () {
        print('onShow ${notification.identifier}');
      };
      notification.onClose = (closeReason) {
        // Only supported on windows, other platforms closeReason is always unknown.
        switch (closeReason) {
          case LocalNotificationCloseReason.userCanceled:
            // do something
            break;
          case LocalNotificationCloseReason.timedOut:
            // do something
            break;
          default:
        }
      };
      notification.onClick = () {
        print('onClick ${notification.identifier}');
      };
      notification.onClickAction = (actionIndex) {
        print('onClickAction ${notification.identifier} - $actionIndex');
      };
    } else {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      final LinuxInitializationSettings initializationSettingsLinux =
          LinuxInitializationSettings(defaultActionName: 'Open notification');
      final InitializationSettings initializationSettings =
          InitializationSettings(
            android: initializationSettingsAndroid,
            linux: initializationSettingsLinux,
          );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestNotificationsPermission();
    }
  }

  LocalNotification notification = LocalNotification(
    title: 'title',
    body: 'body',
  );

  newEvent(String tittle, String body) async {
    try {
      if (Platform.isWindows || Platform.isLinux) {
        notification.title = tittle;
        notification.body = body;
        notification.show();
      } else {
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
              'your channel id',
              'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              number: 1,
            );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          tittle,
          body,
          platformChannelSpecifics,
          payload: 'item x',
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
