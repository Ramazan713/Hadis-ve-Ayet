

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/verse_arabic.dart';

@dao
abstract class VerseArabicDaoOld{

  @Query("""select VA.* from VerseArabic VA, Verse V where VA.mealId = V.id and V.cuzNo=:cuzNo and 
        VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and 
        V.cuzNo=:cuzNo and A.identifier = :identifier)""")
  Future<List<VerseArabic>> getNotDownloadedCuzVerses(String identifier,int cuzNo);

  @Query("""select VA.* from VerseArabic VA, Verse V where VA.mealId = V.id and V.surahId=:surahId and 
        VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and 
        V.surahId=:surahId and A.identifier = :identifier)""")
  Future<List<VerseArabic>> getNotDownloadedSurahVerses(String identifier,int surahId);

  @Query("""select VA.* from VerseArabic VA, Verse V where VA.mealId = V.id and V.pageNo=:pageNo and 
        VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and 
        V.pageNo=:pageNo and A.identifier = :identifier)""")
  Future<List<VerseArabic>> getNotDownloadedPageVerses(String identifier,int pageNo);

  @Query("""select * from VerseArabic where mealId=:mealId and 
        mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and 
        V.id=:mealId and A.identifier = :identifier)""")
  Future<List<VerseArabic>> getNotDownloadedMealIdVerses(String identifier,int mealId);




}
