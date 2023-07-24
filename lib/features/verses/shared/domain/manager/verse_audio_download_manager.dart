

import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:rxdart/rxdart.dart';

abstract class VerseAudioDownloadManager{

  ValueStream<DownloadAudioManagerState>? broadcastListener;

  DownloadAudioManagerState get state;

  void addQueue(DownloadAudioParam param);

  void pause();

  void resume();

  void retry();

  Future<void> cancel();

  void dispose();
}


