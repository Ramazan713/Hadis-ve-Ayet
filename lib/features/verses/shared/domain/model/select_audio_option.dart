
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';

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