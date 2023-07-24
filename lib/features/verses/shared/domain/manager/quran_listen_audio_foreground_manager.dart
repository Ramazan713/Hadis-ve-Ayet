

import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';

abstract class QuranListenAudioBackgroundManager{

  void runService(ListenAudioParam audioParam);

  Future<void> setFinishPlayer();

  Future<void> cancel();

  Future<void> dispose();
}


