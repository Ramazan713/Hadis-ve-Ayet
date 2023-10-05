


import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';

abstract class QuranListenAudioBackgroundManager{

  void runService(ListenAudioParam audioParam);

  Future<void> onStart();

  Future<void> setFinishPlayer();

  Future<void> cancel();

  Future<void> dispose();
}


