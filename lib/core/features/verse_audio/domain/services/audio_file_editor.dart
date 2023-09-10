

import 'dart:io';

abstract class AudioFileEditor{

  Future<void> editAudioFiles(List<File>files);
}