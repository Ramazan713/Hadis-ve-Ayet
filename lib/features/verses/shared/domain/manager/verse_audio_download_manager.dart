

import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/models/resource.dart';
import 'package:rxdart/rxdart.dart';

abstract class VerseAudioDownloadManager{

  ValueStream<DownloadAudioManagerState>? broadcastListener;

  DownloadAudioManagerState get state;

  Future<Resource<void>> downloadSingle(DownloadAudioParam param);

  void addQueue(DownloadAudioParam param);

  void pause();

  void resume();

  void retry();

  Future<void> cancel();

  void dispose();
}


