

import 'package:hadith/core/data/local/views/cuz_audio_view.dart';
import 'package:hadith/core/data/local/views/page_audio_view.dart';
import 'package:hadith/core/data/local/views/surah_audio_view.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/models/downloaded_audio_view_model.dart';

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


extension PageAudioViewExt on PageAudioView{

  DownloadedAudioViewModel toAudioModel(){
    return DownloadedAudioViewModel(
        itemId: pageNo,
        itemName: pageNo.toString(),
        identifier: identifier,
        editionName: editionName,
        isDownloaded: isDownloaded,
        audioEnum: DownloadedAudioViewEnum.page
    );
  }
}