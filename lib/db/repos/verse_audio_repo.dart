
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/db/entities/verse_audio.dart';
import 'package:hadith/db/services/verse_audio_dao.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/verse_audio_model.dart';

class VerseAudioRepo{
  final VerseAudioDaoOld verseAudioDao;

  VerseAudioRepo({required this.verseAudioDao});

  Future<int> insertVerseAudio(VerseAudio verseAudio) =>
      verseAudioDao.insertVerseAudio(verseAudio);

  Future<List<int>> insertVerseAudios(List<VerseAudio> verseAudios) =>
      verseAudioDao.insertVerseAudios(verseAudios);

  Future<List<VerseAudio>> getVerseAudios(String identifier,List<int>verseIds) =>
      verseAudioDao.getVerseAudios(identifier, verseIds);

  Future<void> deleteVerseAudiosWithQuery(String identifier) =>
      verseAudioDao.deleteVerseAudiosWithQuery(identifier);

  Future<List<VerseAudio>>getVerseAudiosWithCuzNo(int cuzNo,String identifier)=>
      verseAudioDao.getVerseAudiosWithCuzNo(cuzNo,identifier);

  Future<List<VerseAudio>>getVerseAudiosWithSurahId(int surahId,String identifier)=>
      verseAudioDao.getVerseAudiosWithSurahId(surahId,identifier);

  Future<void> deleteVerseAudioWithQuery(String identifier,int mealId) =>
    verseAudioDao.deleteVerseAudioWithQuery(identifier, mealId);


  Future<bool> validateVerseAudiosAndRemove(List<VerseAudioEntityOld>audioEntities)async{
    String appDocDir = await VerseAudio.appDocDirPath();
    bool anyMissing=false;
    for (var audioEntity in audioEntities) {
        final file = VerseAudio.getAudioFileWithDir(appDocDir, audioEntity.fileName??"");
        if(!file.existsSync()){
          await verseAudioDao.deleteVerseAudioWithQuery(audioEntity.identifier, audioEntity.mealId);
          anyMissing=true;
        }
    }
    return !anyMissing;
  }

  Future<bool> isVerseAudioExits(AudioParam audioParam,String identifier)async{
    IntData?intData;
    switch(audioParam.option){
      case QuranAudioOption.verse:
        intData = await verseAudioDao.isVerseAudiosExistsWithMeal(audioParam.mealId, identifier);
        break;
      case QuranAudioOption.surah:
        intData = await verseAudioDao.isVerseAudiosExistsWithSurah(audioParam.surahId, identifier);
        break;
      case QuranAudioOption.page:
        intData = await verseAudioDao.isVerseAudiosExistsWithPage(audioParam.pageNo, identifier);
        break;
      case QuranAudioOption.cuz:
        intData = await verseAudioDao.isVerseAudiosExistsWithCuzNo(audioParam.cuzNo, identifier);
        break;
    }
    return intData?.data == 1 ? true : false;
  }




}