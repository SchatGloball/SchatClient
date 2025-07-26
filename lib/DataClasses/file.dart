import 'dart:typed_data';

import 'package:schat2/env.dart';

class FileData
{
  FileData(String pathD, List<int> dataD, String nameFile) {
    extension = nameFile.split('.').last;
    path = pathD;
    data = dataD;
    name= nameFile;
  }

  get int8List
  {
    return Uint8List.fromList(data);
  }
  get isImg
  {
    return Env.image.contains(extension);
  }
  get isSound
  {
    return Env.audio.contains(extension);
  }
  get isVideo
  {
    return Env.video.contains(extension);
  }
  late String extension;
  late String path;
  late List<int> data;
  late String name;
}