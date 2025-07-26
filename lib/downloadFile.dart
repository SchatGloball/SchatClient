import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schat2/allWidgets/infoDialog.dart';
import 'package:uuid/uuid.dart';

import 'eventStore.dart';
//import 'dart:html' as html;


var uuid = const Uuid();


downloadFile(String fileExtension, url)async
{
  String name = uuid.v4();
  if(!config.isWeb)
  {
    if(Platform.isAndroid||Platform.isWindows)
      {
        Permission.backgroundRefresh.request();
        PermissionStatus status = await Permission.storage.status;
        if(!status.isGranted) {
          PermissionStatus statusReq = await Permission.storage.request();
          if(!statusReq.isGranted) {
      //      return;
          }
        }

      }

        final response = await http.get(Uri.parse(url));
        String? filePath = await FilePicker.platform.saveFile(
          dialogTitle: 'Save File To',
          fileName: '$name.$fileExtension',
          type: FileType.custom,
          allowedExtensions: [fileExtension], // Ограничивает типы файлов в диалоге
          bytes: response.bodyBytes, // Передаем данные прямо в saveFile
        );



  // String? directoryPath = await FilePicker.platform.getDirectoryPath();
  //
  // final response = await http.get(Uri.parse(url));
  //
  // File file = File('$directoryPath/$name.$fileExtension');
  // await file.writeAsBytes(response.bodyBytes);
  }
  else{
  //  html.AnchorElement anchor = html.AnchorElement(href: url);
  // anchor.target = '_blank';
  // anchor.download = '$name.$fileExtension'; // название файла, которое будет использовано при сохранении
  // anchor.click();
  }
  
}