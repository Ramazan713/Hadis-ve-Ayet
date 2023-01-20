

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/helper/download_voice_entity.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';

@dao
abstract class VerseAudioStateDao{

  @Query("""select VA.mealId,VA.fileName,VA.identifier,V.surahId,V.cuzNo,V.verseNumber,S.name surahName,
    V.pageNo,E.name editionName from VerseAudio VA, Verse V,Surah S,AudioEdition E where E.identifier = VA.identifier and
    VA.mealId = V.id and S.id = V.surahId and cuzNo=:cuzNo and VA.identifier=:identifier order by mealId""")
  Future<List<VerseAudioEntity>>getAudioStateWithCuzNo(int cuzNo,String identifier);

  @Query("""select VA.mealId,VA.fileName,VA.identifier,V.surahId,V.cuzNo,V.verseNumber,S.name surahName,V.pageNo,
    E.name editionName from VerseAudio VA, Verse V,Surah S,AudioEdition E where E.identifier = VA.identifier and
    VA.mealId = V.id and S.id = V.surahId and surahId=:surahId and VA.identifier=:identifier order by mealId""")
  Future<List<VerseAudioEntity>>getAudioStateWithSurahId(int surahId,String identifier);

  @Query("""select VA.mealId,VA.fileName,VA.identifier,V.surahId,V.cuzNo,V.verseNumber,S.name surahName,
    V.pageNo,E.name editionName from VerseAudio VA, Verse V,Surah S,AudioEdition E where E.identifier = VA.identifier and
    VA.mealId = V.id and S.id = V.surahId and pageNo=:pageNo and VA.identifier=:identifier order by mealId""")
  Future<List<VerseAudioEntity>>getAudioStateWithPageNo(int pageNo,String identifier);

  @Query("""select VA.mealId,VA.fileName,VA.identifier,V.surahId,V.cuzNo,V.verseNumber,S.name surahName,
    V.pageNo,E.name editionName from VerseAudio VA, Verse V,Surah S,AudioEdition E where E.identifier = VA.identifier and 
    VA.mealId = V.id and S.id = V.surahId and mealId=:mealId and VA.identifier=:identifier order by mealId""")
  Future<List<VerseAudioEntity>>getAudioStateWithMealId(int mealId,String identifier);





  @Query("""select VA.mealId,V.surahId,V.cuzNo,VA.verseNumberTr verseNumber,S.name surahName,VA.id verseId from 
    VerseArabic VA, Verse V,Surah S where VA.mealId = V.id and S.id = V.surahId and V.id=:mealId and 
    VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and 
    V.id=:mealId and A.identifier = :identifier) order by mealId""")
  Future<List<DownloadVoiceEntity>>getNotDownloadedMealIdVerses(int mealId,String identifier);


  @Query("""select VA.mealId,V.surahId,V.cuzNo,VA.verseNumberTr verseNumber,S.name surahName,VA.id verseId from 
    VerseArabic VA, Verse V,Surah S where VA.mealId = V.id and S.id = V.surahId and V.surahId=:surahId and 
    VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and 
    V.surahId=:surahId and A.identifier = :identifier) order by mealId""")
  Future<List<DownloadVoiceEntity>>getNotDownloadedSurahVerses(int surahId,String identifier);

  @Query("""select VA.mealId,V.surahId,V.cuzNo,VA.verseNumberTr verseNumber,S.name surahName,VA.id verseId from 
    VerseArabic VA, Verse V,Surah S where VA.mealId = V.id and S.id = V.surahId and V.cuzNo=:cuzNo and 
    VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and 
    V.cuzNo=:cuzNo and A.identifier = :identifier) order by mealId""")
  Future<List<DownloadVoiceEntity>>getNotDownloadedCuzVerses(int cuzNo,String identifier);

  @Query("""select VA.mealId,V.surahId,V.cuzNo,VA.verseNumberTr verseNumber,S.name surahName,VA.id verseId from 
    VerseArabic VA, Verse V,Surah S where VA.mealId = V.id and S.id = V.surahId and V.pageNo=:pageNo and 
    VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and 
    V.pageNo=:pageNo and A.identifier = :identifier) order by mealId""")
  Future<List<DownloadVoiceEntity>>getNotDownloadedPageVerses(int pageNo,String identifier);

}