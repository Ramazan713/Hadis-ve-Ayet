
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';

enum SelectAudioOption{
  cuz, surah, verse;

  List<QuranAudioOption> getSelectOptions(){
    switch(this){
      case SelectAudioOption.cuz:
        return QuranAudioOption.values;
      case SelectAudioOption.surah:
        return [QuranAudioOption.surah, QuranAudioOption.page, QuranAudioOption.verse];
      default:
        return [QuranAudioOption.verse];
    }
  }
}