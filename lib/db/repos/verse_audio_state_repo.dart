

import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/db/services/verse_audio_state_dao.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/db/entities/helper/download_voice_entity.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';

class VerseAudioStateRepo{
  late final VerseAudioStateDao _audioStateDao;

  VerseAudioStateRepo({required VerseAudioStateDao audioStateDao}){
    _audioStateDao = audioStateDao;
  }

  Future<List<VerseAudioEntity>>getStateAudioVerses(AudioParam audioParam,String identifier){
    switch(audioParam.option){
      case QuranAudioOption.verse:
        return _audioStateDao.getAudioStateWithMealId(audioParam.mealId,identifier);
      case QuranAudioOption.surah:
        return _audioStateDao.getAudioStateWithSurahId(audioParam.surahId,identifier);
      case QuranAudioOption.page:
        return _audioStateDao.getAudioStateWithPageNo(audioParam.pageNo,identifier);
      case QuranAudioOption.cuz:
        return _audioStateDao.getAudioStateWithCuzNo(audioParam.cuzNo,identifier);
    }
  }


  Future<List<DownloadVoiceEntity>>getNotDownloadedAudioVerses(AudioParam audioParam,String identifier){
    switch(audioParam.option){
      case QuranAudioOption.verse:
        return _audioStateDao.getNotDownloadedMealIdVerses(audioParam.mealId,identifier);
      case QuranAudioOption.surah:
        return _audioStateDao.getNotDownloadedSurahVerses(audioParam.surahId,identifier);
      case QuranAudioOption.page:
        return _audioStateDao.getNotDownloadedPageVerses(audioParam.pageNo,identifier);
      case QuranAudioOption.cuz:
        return _audioStateDao.getNotDownloadedCuzVerses(audioParam.cuzNo,identifier);
    }
  }

  Future<int?> getSurahVersePosition(int surahId,int mealId)=>_audioStateDao.getSurahVersePosition(surahId, mealId);


}