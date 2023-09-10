


import 'package:hadith/core/domain/models/i_menu_item.dart';

enum QuranAudioOption with IMenuItem{
  cuz,
  surah,
  page,
  verse;

  String get description{
    switch(this){
      case QuranAudioOption.cuz:
        return "Cüz";
      case QuranAudioOption.surah:
        return "Sure";
      case QuranAudioOption.page:
        return "Sayfa";
      case QuranAudioOption.verse:
        return "Ayet";
    }
  }

  @override
  get title => description;

  @override
  get iconInfo => null;

}
