

import 'package:hadith/core/data/local/entities/verse_entity.dart';
import 'package:hadith/core/data/mapper/verse/verse_mapper.dart';
import 'package:hadith/core/data/local/services/surah_dao.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';

class GetVerses{
  late final SurahDao _surahDao;

  GetVerses({
    required SurahDao surahDao
  }){
    _surahDao = surahDao;
  }

  Future<List<Verse>> call(List<VerseEntity> verseEntities)async{
    final surahMap = <int,String>{};
    final verses = <Verse>[];

    for (final verseEntity in verseEntities) {
      final String surahName;
      final surahId = verseEntity.surahId;

      if(surahMap.containsKey(surahId)){
        surahName = surahMap[surahId] ?? "";
      }else{
        surahName = (await _surahDao.getSurahNameById(surahId)) ?? "";
        surahMap[surahId] = surahName;
      }
      verses.add(verseEntity.toVerse(surahName: surahName));
    }
    return verses;
  }


  Future<Verse?> getVerseByEntity(VerseEntity? verseEntity)async{
    if(verseEntity == null) return null;
    final surahName = await _surahDao.getSurahNameById(verseEntity.surahId);
    return verseEntity.toVerse(surahName: surahName??"");
  }

}