

import 'dart:io';

import 'package:hadith/core/domain/services/file_service.dart';
import 'package:path_provider/path_provider.dart';

class FileServiceImpl extends FileService{

  String? _tempDir;

  @override
  Future<void> init() async{
    _tempDir = await _getTempPath();
  }


  @override
  Future<File> writeFile(List<int> bytes, String fileName) async{
    final tempDir = await _getTempPath();

    final file = File("$tempDir/$fileName");
    await file.create(recursive: true);
    await file.writeAsBytes(bytes);
    return file;
  }


  @override
  Future<void> deleteFiles(List<File> files) async{
    for(final file in files){
      await file.delete();
    }
  }

  @override
  Future<void> deleteFilesWithFileNames(List<String> fileNames) async{
    final tempDir = await _getTempPath();

    final files = fileNames.map((e) => File("$tempDir/$e")).toList();
    await deleteFiles(files);
  }

  @override
  Future<List<File>> getFilesFromFileNames(List<String> fileNames) async{
    final tempDir = await _getTempPath();
    return fileNames.map((e) => File("$tempDir/$e")).toList();
  }

  Future<String> _getTempPath()async{
    var tempDir = _tempDir;
    if(tempDir!=null) return tempDir;

    tempDir = (await getTemporaryDirectory()).path;
    _tempDir = tempDir;

    return tempDir;
  }





}