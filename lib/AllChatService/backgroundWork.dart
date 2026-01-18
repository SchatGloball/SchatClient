import 'dart:io';
import 'package:workmanager/workmanager.dart';
import '../APIService/chatService.dart';
import '../Notification/notification.dart';
import '../eventStore.dart';
import '../localization/localization.dart';
import '../DataClasses/configuration.dart';
import '../LocalStorage/storage.dart';

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
      //    print('_______________________________1__________________________________');
          try {
            // Инициализируем сервис уведомлений
            NotificationService notification = NotificationService();
            
              await notification.init();
            


            // Инициализируем хранилище
            LocalStorage localStorage = LocalStorage();

        //    print('_______________________________2__________________________________');
              await localStorage.initDataBase(false, false);
            // Загружаем конфигурацию из хранилища
             Map configuration = await localStorage.getAppConfig();       
 Configuration localConfig = Configuration(configuration, isWeb: false); 

 //print('_______________________________3__________________________________');
 
            // Обновляем токены
            Map tokens = await localConfig.server.userApi.refreshToken(localConfig.server.refreshToken);
            
           localConfig.server.accessToken = tokens['accessToken'];
   
   //         print('_______________________________4__________________________________');
            // Создаем экземпляр ChatService
            ChatService chatApi = ChatService(
                localConfig.server.address, 
                localConfig.server.port, 
                isWeb: false
              );
       //    print('_______________________________5__________________________________');
            
            // Проверяем наличие новых сообщений
            bool result = await chatApi.notificationNewMessage(localConfig.server.accessToken);
           // print('_______________________________6__________________________________');
            // Отправляем уведомление, если есть новые сообщения
            if (result) {
             
                await notification.newEvent('Schat', 'New Message');
             
            } else {
              print('Background task: no new messages');
            }
          } catch (e) {
            print('Background task: unexpected error in task execution: ${e.toString()}');
            print('Stack trace: ${StackTrace.current}');
          }
          
          break;
      }
   
    return Future.value(true);
  });
}

startBackground() async {
    if (Platform.isAndroid) {
      try {
        await Workmanager().initialize(
          callbackDispatcher
        );
        
        // Регистрируем периодическую задачу
        // uniqueName - уникальное имя для задачи
        // taskName - имя задачи, которое должно совпадать с case в callbackDispatcher
        await Workmanager().registerPeriodicTask(
          simplePeriodicTask, // uniqueName
          simplePeriodic1HourTask, // taskName
          frequency: const Duration(minutes: 15),
          constraints: Constraints(
            networkType: NetworkType.connected,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresDeviceIdle: false,
            requiresStorageNotLow: false,
          ),
        );
        print('Background task registered successfully');
      } catch (e) {
        print('Error registering background task: ${e.toString()}');
      }
    } else {
      backGroundWorkDesktop();
    }
}

backGroundWorkDesktop() async {
  print('object');
  final bool n = await config.server.chatApi.notificationNewMessage(config.server.accessToken);
  if (n) {
    notification.newEvent(
        'Schat',
        Localization.localizationData[config.language]['notification']
            ['newMessage']);
  }
  return Future.delayed(
      const Duration(seconds: 185), () => backGroundWorkDesktop());
}
