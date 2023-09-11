

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/verse_arabic_entity.dart';

@dao
abstract class VerseArabicDao{


  @Query("""select * from verseArabic where mealId=:mealId""")
  Future<List<VerseArabicEntity>> getArabicVersesByMealId(int mealId);


  @Query("""
    select VA.* from VerseArabic VA, Verse V 
    where VA.mealId = V.id and V.id=:mealId and VA.mealId not in 
    (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.id=:mealId and A.identifier = :identifier)
    order by mealId
  """)
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithMealId(int mealId, String identifier);

  @Query("""
    select VA.* from VerseArabic VA, Verse V 
    where VA.mealId = V.id and V.id in (:mealIds) and VA.mealId not in 
    (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.id in (:mealIds) and A.identifier = :identifier)
    order by mealId
  """)
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithMealIdList(List<int> mealIds, String identifier);


  @Query("""
    select VA.* from VerseArabic VA, Verse V 
    where VA.mealId = V.id and V.surahId=:surahId and VA.mealId not in 
    (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.surahId=:surahId and A.identifier = :identifier)
    order by mealId
  """)
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithSurahId(int surahId, String identifier);

  @Query("""
    select VA.* from VerseArabic VA, Verse V 
    where VA.mealId = V.id and V.surahId=:surahId and V.id >= :startVerseId and VA.mealId not in 
    (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.surahId=:surahId and A.identifier = :identifier)
    order by mealId
  """)
  Future<List<VerseArabicEntity>> getNotDownloadedVerseArabicsWithSurahId(int surahId, String identifier, int startVerseId);


  @Query("""
    select VA.* from VerseArabic VA, Verse V 
    where VA.mealId = V.id and V.cuzNo=:cuzNo and VA.mealId not in 
    (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.cuzNo=:cuzNo and A.identifier = :identifier)
    order by mealId
  """)
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithCuzNo(int cuzNo,String identifier);

  @Query("""
    select VA.* from VerseArabic VA, Verse V 
    where VA.mealId = V.id and V.cuzNo=:cuzNo and V.id >= :startVerseId and VA.mealId not in 
    (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.cuzNo=:cuzNo and A.identifier = :identifier)
    order by mealId
  """)
  Future<List<VerseArabicEntity>> getNotDownloadedVerseArabicsWithCuzNo(int cuzNo, String identifier, int startVerseId);



  @Query("""
    select VA.* from VerseArabic VA, Verse V 
    where VA.mealId = V.id and V.pageNo=:pageNo and VA.mealId not in 
    (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.pageNo=:pageNo and A.identifier = :identifier)
    order by mealId
  """)
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithPageNo(int pageNo,String identifier);

  @Query("""
    select VA.* from VerseArabic VA, Verse V 
    where VA.mealId = V.id and V.pageNo=:pageNo and V.id >= :startVerseId and VA.mealId not in 
    (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.pageNo=:pageNo and A.identifier = :identifier)
    order by mealId
  """)
  Future<List<VerseArabicEntity>> getNotDownloadedVerseArabicsWithPageNo(int pageNo, String identifier, int startVerseId);

}