

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';

@dao
abstract class VerseDao{

  // by surah
  @Query("""
    select * from verses where surahId=:surahId limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getPagingVersesBySurahId(int surahId,int pageSize, int startIndex);

  @Query("select count(*) from verses where surahId=:surahId")
  Future<int?> getVerseCountBySurahId(int surahId);

  @Query("select exists(select * from verses where surahId = :surahId and id = :id)")
  Future<bool?> getExistsVerseBySurahId(int surahId, int id);

  @Query("""
    select count(*) from verses where surahId = :surahId and id < :id 
  """)
  Future<int?> getSurahPosById(int id,int surahId);


  // by cuz
  @Query("""
    select * from verses where cuzNo=:cuzNo limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getPagingVersesByCuzNo(int cuzNo, int pageSize, int startIndex);

  @Query("select count(*) from verses where cuzNo=:cuzNo")
  Future<int?> getVerseCountByCuzNo(int cuzNo);

  @Query("select exists(select * from verses where cuzNo = :cuzNo and id = :id)")
  Future<bool?> getExistsVerseByCuzNo(int cuzNo, int id);

  @Query("""
    select count(*) from verses where cuzNo = :cuzNo and id < :id 
  """)
  Future<int?> getCuzPosById(int id,int cuzNo);



  // by list
  @Query("""
    select V.* from verses V, ListVerses LV where V.id = LV.verseId and LV.listId = :listId
    order by LV.pos desc limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getPagingVersesByListId(int listId, int pageSize, int startIndex);

  @Query("""
    select count(*) from verses V, listVerses LV where V.id = LV.verseId and LV.listId = :listId
  """)
  Future<int?> getVerseCountByListId(int listId);

  @Query("""select exists(
    select V.* from verses V, ListVerses LV where V.id = LV.verseId and LV.listId = :listId
    and V.id = :id)
  """)
  Future<bool?> getExistsVerseByListId(int listId, int id);


  // by topic
  @Query("""
    select V.* from verses V, verseTopics VT where V.id = VT.verseId and VT.topicId = :topicId
    limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getPagingVersesByTopicId(int topicId, int pageSize, int startIndex);

  @Query("""
    select count(*) from verses V, verseTopics VT where V.id = VT.verseId and VT.topicId = :topicId
  """)
  Future<int?> getVerseCountByTopicId(int topicId);

  @Query("""select exists(
    select V.* from verses V, verseTopics VT where V.id = VT.verseId and VT.topicId = :topicId
    and V.id = :id)
  """)
  Future<bool?> getExistsVerseByTopicId(int topicId, int id);


  // by page
  @Query("""
    select * from verses where pageNo = :pageNo
  """)
  Future<List<VerseEntity>> getPagingVersesByPageNo(int pageNo);

  @Query("""
    select count(distinct pageNo) from verses
  """)
  Future<int?> getVerseCountByPageNo();

  @Query("""
    select exists(select * from verses where pageNo = :pageNo and id = :id)
  """)
  Future<bool?> getExistsVerseByPageNo(int pageNo, int id);



  // general
  @Query("""
    select * from verses where id = :id
  """)
  Future<VerseEntity?> getVerseById(int id);

  @Query("""
    select count(*) from verses where id<:id
  """)
  Future<int?> getPosById(int id);


  @Query("""
    select V.* from verses V, ListVerses LV where V.id = LV.verseId and LV.listId = :listId 
    order by LV.pos desc
  """)
  Future<List<VerseEntity>> getVersesFromListId(int listId);

  @Query("""
    select * from verses where id in (:ids)
  """)
  Future<List<VerseEntity>> getVersesByIds(List<int> ids);

  @Query("""
    select * from verses where surahId = :surahId order by id limit :surahSize offset :offset
  """)
  Future<List<VerseEntity>> getVersesByOffsetAndSurah(int surahId, int surahSize, int offset);
}