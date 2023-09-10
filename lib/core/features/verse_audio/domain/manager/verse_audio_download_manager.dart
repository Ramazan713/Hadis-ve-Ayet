
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/core/utils/resource.dart';
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


