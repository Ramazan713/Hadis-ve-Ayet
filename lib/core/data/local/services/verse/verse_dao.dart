

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';

@dao
abstract class VerseDao{

  // by surah
  @Query("""
    select * from verse where surahId=:surahId limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getPagingVersesBySurahId(int surahId,int pageSize, int startIndex);

  @Query("select count(*) from verse where surahId=:surahId")
  Future<int?> getVerseCountBySurahId(int surahId);

  @Query("select exists(select * from verse where surahId = :surahId and id = :id)")
  Future<bool?> getExistsVerseBySurahId(int surahId, int id);

  @Query("""
    select count(*) from verse where surahId = :surahId and id < :id 
  """)
  Future<int?> getSurahPosById(int id,int surahId);


  // by cuz
  @Query("""
    select * from verse where cuzNo=:cuzNo limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getPagingVersesByCuzNo(int cuzNo, int pageSize, int startIndex);

  @Query("select count(*) from verse where cuzNo=:cuzNo")
  Future<int?> getVerseCountByCuzNo(int cuzNo);

  @Query("select exists(select * from verse where cuzNo = :cuzNo and id = :id)")
  Future<bool?> getExistsVerseByCuzNo(int cuzNo, int id);

  @Query("""
    select count(*) from verse where cuzNo = :cuzNo and id < :id 
  """)
  Future<int?> getCuzPosById(int id,int cuzNo);



  // by list
  @Query("""
    select V.* from verse V, ListVerse LV where V.id = LV.verseId and LV.listId = :listId
    order by LV.pos desc limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getPagingVersesByListId(int listId, int pageSize, int startIndex);

  @Query("""
    select count(*) from verse V, ListVerse LV where V.id = LV.verseId and LV.listId = :listId
  """)
  Future<int?> getVerseCountByListId(int listId);

  @Query("""select exists(
    select V.* from verse V, ListVerse LV where V.id = LV.verseId and LV.listId = :listId
    and V.id = :id)
  """)
  Future<bool?> getExistsVerseByListId(int listId, int id);


  // by topic
  @Query("""
    select V.* from verse V, verseTopic VT where V.id = VT.verseId and VT.topicId = :topicId
    limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getPagingVersesByTopicId(int topicId, int pageSize, int startIndex);

  @Query("""
    select count(*) from verse V, verseTopic VT where V.id = VT.verseId and VT.topicId = :topicId
  """)
  Future<int?> getVerseCountByTopicId(int topicId);

  @Query("""select exists(
    select V.* from verse V, verseTopic VT where V.id = VT.verseId and VT.topicId = :topicId
    and V.id = :id)
  """)
  Future<bool?> getExistsVerseByTopicId(int topicId, int id);



  // general
  @Query("""
    select * from Verse where id = :id
  """)
  Future<VerseEntity?> getVerseById(int id);

  @Query("""
    select count(*) from verse where id<:id
  """)
  Future<int?> getPosById(int id);


  @Query("""
    select V.* from verse V, ListVerse LV where V.id = LV.verseId and LV.listId = :listId 
    order by LV.pos desc
  """)
  Future<List<VerseEntity>> getVersesFromListId(int listId);

  @Query("""
    select * from verse where id in (:ids)
  """)
  Future<List<VerseEntity>> getVersesByIds(List<int> ids);

}