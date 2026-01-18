import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

// Для мобильных платформ
import 'package:permission_handler/permission_handler.dart';


// Для десктопных платформ
import 'package:file_picker/file_picker.dart';

// Для Web
import 'package:universal_html/html.dart' as html;

import 'package:schat2/allWidgets/infoDialog.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();


Future<void> downloadFile({
  required String fileExtension,
  required String url,
  bool showSaveDialog = true,
}) async {
String  fileName = uuid.v4();
  try {
    if (kIsWeb) {
      await _downloadFileWeb(
        url: url,
        fileExtension: fileExtension,
        fileName: fileName,
      );
    } else if (Platform.isAndroid) {
      await _downloadFileMobile(
        url: url,
        fileExtension: fileExtension,
        fileName: fileName,
      );
    } else {
      await _downloadFileDesktop(
        url: url,
        fileExtension: fileExtension,
        fileName: fileName,
        showSaveDialog: showSaveDialog,
      );
    }
  } catch (e) {
    _showErrorDialog('Ошибка при скачивании файла: $e');
    rethrow;
  }
}

/// Скачивание для Web платформы
Future<void> _downloadFileWeb({
  required String url,
  required String fileExtension,
  String? fileName,
}) async {
  final name = fileName ?? uuid.v4();
  
  // Создаем anchor элемент для скачивания
  final anchor = html.AnchorElement(href: url);
  anchor.download = '$name.$fileExtension';
  anchor.target = '_blank';
  
  // Симулируем клик для скачивания
  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}


Future<void> _downloadFileMobile({
  required String url,
  required String fileExtension,
  String? fileName,
}) async {
  // Запрашиваем разрешения для Android
  if (Platform.isAndroid) {
    await _requestAndroidPermissions();
  }

  // Получаем директорию для сохранения
   final directory = await getDownloadDirectory();

  final filePath = '$directory/$fileName.$fileExtension';
  
  // Скачиваем файл
  final response = await http.get(Uri.parse(url));
  
  if (response.statusCode == 200) {
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    
    // Показываем диалог об успешном сохранении
    _showSuccessDialog('Файл сохранен: $filePath');
  } else {
    throw Exception('Ошибка HTTP: ${response.statusCode}');
  }
}

/// Скачивание для десктопных платформ (Windows/macOS/Linux)
Future<void> _downloadFileDesktop({
  required String url,
  required String fileExtension,
  String? fileName,
  bool showSaveDialog = true,
}) async {
  final name = fileName ?? uuid.v4();
  
  if (showSaveDialog) {
    // Показываем диалог сохранения файла
    final String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Сохранить файл',
      fileName: '$name.$fileExtension',
      type: FileType.custom,
      allowedExtensions: [fileExtension],
    );
    
    if (filePath != null) {
      final response = await http.get(Uri.parse(url));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      _showSuccessDialog('Файл сохранен: $filePath');
    }
  } else {
    // Сохраняем автоматически в папку загрузок
    final directory = await getDownloadDirectory();
    final filePath = '$directory/$name.$fileExtension';
    
    if (filePath != null) {
      final response = await http.get(Uri.parse(url));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      _showSuccessDialog('Файл сохранен: $filePath');
    }
  }
}

/// Получает директорию для сохранения файлов в зависимости от платформы
Future<String?> getDownloadDirectory() async {
String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Выберите директорию для сохранения файла',
      );
      return  selectedDirectory;
}

/// Запрашивает разрешения для Android
Future<bool> _requestAndroidPermissions() async {
   PermissionStatus status = await Permission.storage.status;
    
    if (!status.isGranted) {
      await Permission.mediaLibrary.request();
    status = await Permission.storage.request();
    
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      throw Exception('Разрешение на доступ к хранилищу отклонено. Пожалуйста, включите его в настройках.');
    }
    
  }
  
  // Для Android 10+ может потребоваться управление внешним хранилищем
  if (await Permission.manageExternalStorage.isRestricted) {
    await Permission.manageExternalStorage.request();
  }
return true;

}

/// Показывает диалог об ошибке
void _showErrorDialog(String message) {
  // Используйте ваш InfoDialog или другой способ показа ошибки
  // InfoDialog.show(message: message, isError: true);
  if (kDebugMode) {
    print('Download Error: $message');
  }
}

/// Показывает диалог об успешном сохранении
void _showSuccessDialog(String message) {
  // InfoDialog.show(message: 'Файл успешно скачан!\n$message');
  if (kDebugMode) {
    print('Download Success: $message');
  }
}




