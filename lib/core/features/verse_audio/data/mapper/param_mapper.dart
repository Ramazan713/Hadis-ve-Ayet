

import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/audio_param_builder.dart';

extension ListenAudioParamExt on ListenAudioParam{

  DownloadAudioParam toDownloadAudioParam({required AudioQualityEnum qualityEnum}){
    return DownloadAudioParam(
      op: op,
      identifier: identifier,
      startVerseId: startVerseId,
      itemIdForOption: itemId,
      audioQualityEnum: qualityEnum
    );
  }

  AudioParamBuilder toAudioParamBuilder({bool checkNotification = false}){
    return AudioParamBuilder(
      startVerseId: startVerseId,
      op: op,
      identifier: identifier,
      itemId: itemId,
      checkNotification: checkNotification
    );
  }
}

extension DownloadAudioParamExt on DownloadAudioParam{

  ListenAudioParam toListenAudioParam(){
    return ListenAudioParam(
      itemId: itemIdForOption,
      identifier: identifier,
      op: op,
      startVerseId: startVerseId
    );
  }
}
