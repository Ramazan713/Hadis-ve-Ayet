

import 'package:flutter/services.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/verse_downloaded_model.dart';
import 'package:hadith/features/verses/shared/domain/util/stream_resource.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

abstract class QuranDownloadService{

  ValueStream<StreamResource<VerseDownloadedVoiceModel>>? get streamDownloadListener;

  Future<Resource<Uint8List>> downloadSingleAudio({
    required String identifier,
    required int verseId,
    AudioQualityEnum audioQuality = AudioQualityEnum.q64,
  });


  Future<void> initStream(int itemCount);

  Future<void> startStreamDownloading({
    required String identifier,
    required List<VerseDownloadedVoiceModel> models,
    required AudioQualityEnum audioQuality
  });

  void pause();

  void resume();

  Future<void> cancel();

  Future<void> dispose();

}