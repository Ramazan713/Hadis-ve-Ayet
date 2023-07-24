

import 'dart:io';

abstract class FileService{

  Future<void> init();

  Future<File> writeFile(List<int> bytes, String fileName);

  Future<void> deleteFiles(List<File>files);

  Future<void> deleteFilesWithFileNames(List<String> fileNames);

  Future<List<File>> getFilesFromFileNames(List<String> fileNames);
}