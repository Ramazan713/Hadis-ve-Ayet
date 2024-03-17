

import 'package:hadith/core/domain/models/i_menu_item.dart';

enum DownloadedAudioViewEnum with IMenuItem{
  surah,
  cuz,
  page
  ;

  String get description{
    switch(this){
      case DownloadedAudioViewEnum.surah:
        return "Sure";
      case DownloadedAudioViewEnum.cuz:
        return "Cuz";
      case DownloadedAudioViewEnum.page:
        return "Sayfa";
    }
  }

  @override
  get title => description;

  @override
  get iconInfo => null;
}