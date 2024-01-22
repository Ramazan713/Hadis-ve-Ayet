
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

abstract class VerseAudioDownloadManager{

  ValueStream<DownloadAudioManagerState>? broadcastListener;

  DownloadAudioManagerState get state;

  Future<Resource<void>> downloadSingle(DownloadAudioParam param);

  Future<Resource<void>> downloadMultiVerse({
    required List<int> verseIds,
    required String identifier,
    required AudioQualityEnum quality
  });

  void addQueue(DownloadAudioParam param);

  void pause();

  void resume();

  void retry();

  Future<void> cancel();

  void dispose();
}


