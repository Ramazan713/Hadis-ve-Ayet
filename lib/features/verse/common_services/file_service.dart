


import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService{

  String? _appDocDir;

  FileService(){
    _initAppDir();
  }

  Future<void>_initAppDir()async{
    _appDocDir = (await getTemporaryDirectory()).path;
  }

  Future<File>writeFile(List<int> bytes,String fileName)async {
    final file = File("$_appDocDir/$fileName");
    await file.create(recursive: true);
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> deleteFiles(List<File>files)async{
    for(final file in files){
      await file.delete();
    }
  }
}