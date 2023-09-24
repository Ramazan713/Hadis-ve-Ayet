

import 'package:hadith/core/data/local/views/cuz_audio_view.dart';
import 'package:hadith/core/data/local/views/surah_audio_view.dart';
import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';

extension CuzAudioViewExt on CuzAudioView{

  DownloadedAudioViewModel toAudioModel(){
    return DownloadedAudioViewModel(
      itemId: cuzNo,
      itemName: cuzName,
      identifier: identifier,
      editionName: editionName,
      isDownloaded: isDownloaded,
      audioEnum: DownloadedAudioViewEnum.cuz
    );
  }
}

extension SurahAudioViewExt on SurahAudioView{

  DownloadedAudioViewModel toAudioModel(){
    return DownloadedAudioViewModel(
        itemId: surahId,
        itemName: surahName,
        identifier: identifier,
        editionName: editionName,
        isDownloaded: isDownloaded,
        audioEnum: DownloadedAudioViewEnum.surah
    );
  }
}