

import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';

abstract class QuranDownloadAudioBackgroundManager{

  void addDownloadQueue(DownloadAudioParam param);

  Future<void> cancel();

  Future<void> dispose();
}