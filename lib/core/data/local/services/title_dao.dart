

import 'package:floor/floor.dart';

@dao
abstract class TitleDao{

  @Query("""
    select name from topic where id = :topicId
  """)
  Future<String?> getTopicTitleById(int topicId);

  @Query("""
    select name from counters where id = :id
  """)
  Future<String?> getCounterTitleById(int id);

  @Query("""
    select name from list where id = :listId
  """)
  Future<String?> getListTitleById(int listId);


  @Query("""
    select name from surah where id = :surahId
  """)
  Future<String?> getSurahTitleById(int surahId);


  @Query("""
    select name from cuz where cuzNo = :cuzNo
  """)
  Future<String?> getCuzTitleById(int cuzNo);

}