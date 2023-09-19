

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/cuz_entity.dart';
import 'package:hadith/core/data/local/entities/surah_entity.dart';

@dao
abstract class SelectVersePageDao{

  @Query("""
    select * from surah
  """)
  Future<List<SurahEntity>> getSurahes();

  @Query("""
    select * from cuz
  """)
  Future<List<CuzEntity>> getCuzs();

  @Query("""
    select verseNumber from verse where surahId = :surahId
  """)
  Future<List<String>> getVerseNumbers(int surahId);

  @Query("""
    select ifnull(max(pageNo),0) from verse
  """)
  Future<int?> getMaxPage();

  @Query("""
    select id from verse 
    where surahId = :surahId and cuzNo = :cuzNo and verseNumber = :verseNumber
  """)
  Future<int?> getVerseId(int surahId, int cuzNo, String verseNumber);

  @Query("""
    select count(*) from verse 
    where pageNo = :pageNo and surahId = :surahId and cuzNo = :cuzNo and id <= :id
  """)
  Future<int?> getPagePosition(int id, int pageNo, int surahId, int cuzNo);


  @Query("""select exists(
    select 1 from surah S, Verse V 
    where V.surahId = S.id and V.cuzNo = :cuzNo and S.id = :surahId)
  """)
  Future<bool?> existsSurahByCuzNo(int surahId, int cuzNo);


  @Query("""select exists(
    select 1 from surah S, Verse V 
    where V.surahId = S.id and V.cuzNo = :cuzNo and S.id = :surahId and verseNumber = :verseNumber)
  """)
  Future<bool?> existsCuzBySurah(int cuzNo, int surahId, String verseNumber);


  @Query("""select exists(
    select 1 from Verse
    where cuzNo = :cuzNo and pageNo = :pageNo)
  """)
  Future<bool?> existsPageByCuzNo(int pageNo, int cuzNo);



  @Query("""select exists(
    select 1 from Verse
    where surahId = :surahId and pageNo = :pageNo)
  """)
  Future<bool?> existsPageBySurahId(int pageNo, int surahId);

  @Query("""select exists(
    select 1 from Verse
    where surahId = :surahId and pageNo = :pageNo and verseNumber = :verseNumber)
  """)
  Future<bool?> existsPageBySurah(int pageNo, int surahId, String verseNumber);


  @Query("""select exists(
    select 1 from Verse
    where surahId = :surahId and cuzNo = :cuzNo and verseNumber = :verseNumber)
  """)
  Future<bool?> existsVerseNumber(String verseNumber, int surahId, int cuzNo);


  @Query("""select exists(
    select 1 from Verse
    where surahId = :surahId and cuzNo = :cuzNo and verseNumber = :verseNumber and pageNo = :pageNo)
  """)
  Future<bool?> existsVerseNumberWithPageNo(String verseNumber, int surahId, int cuzNo, int pageNo);



  @Query("""
    select S.* from surah S, Verse V 
    where V.surahId = S.id and V.cuzNo = :cuzNo limit 1
  """)
  Future<SurahEntity?> getFirstSurahByCuzNo(int cuzNo);

  @Query("""
    select S.* from surah S, Verse V 
    where V.surahId = S.id and V.pageNo = :pageNo limit 1
  """)
  Future<SurahEntity?> getFirstSurahByPageNo(int pageNo);

  @Query("""
    select C.* from cuz C, Verse V 
    where V.cuzNo = C.cuzNo and V.surahId = :surahId and V.verseNumber = :verseNumber limit 1
  """)
  Future<CuzEntity?> getFirstCuzBySurah(int surahId, String verseNumber);

  @Query("""
    select C.* from cuz C, Verse V 
    where V.cuzNo = C.cuzNo and V.surahId = :surahId limit 1
  """)
  Future<CuzEntity?> getFirstCuzBySurahId(int surahId);

  @Query("""
    select C.* from cuz C, Verse V 
    where V.cuzNo = C.cuzNo and V.pageNo = :pageNo limit 1
  """)
  Future<CuzEntity?> getFirstCuzByPageNo(int pageNo);

  @Query("""
    select pageNo from Verse V 
    where V.cuzNo = :cuzNo limit 1
  """)
  Future<int?> getFirstPageByCuzNo(int cuzNo);


  @Query("""
    select pageNo from Verse V 
    where V.surahId = :surahId and verseNumber = :verseNumber limit 1
  """)
  Future<int?> getFirstPageBySurah(int surahId, String verseNumber);


  @Query("""
    select verseNumber from Verse
    where surahId = :surahId and cuzNo = :cuzNo limit 1
  """)
  Future<String?> getFirstVerseNumber(int surahId, int cuzNo);


  @Query("""
    select verseNumber from Verse
    where surahId = :surahId and cuzNo = :cuzNo and pageNo = :pageNo limit 1
  """)
  Future<String?> getFirstVerseNumberWithPageNo(int surahId, int cuzNo, int pageNo);

}