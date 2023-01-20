

import 'dart:io';

import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';

class FileAudioEditor{

  Future<void>reWriteFiles(List<File>files)async{
    for(final file in files){
      final tempFile = File("${file.parent.path}/temp.mp3");
      await file.copy(tempFile.path);
      await file.delete();
      await FFmpegKit.execute('-i ${tempFile.path} -acodec copy ${file.path}');
      await tempFile.delete();
    }
  }

}