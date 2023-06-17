

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/hadith_entity.dart';

@dao
abstract class HadithAllDao{

  //Hadith All Pagination Functions
  @Query("select count(*) from hadith where bookId = :bookId")
  Future<int?> getHadithCountByBookId(int bookId);

  @Query("select * from hadith where bookId = :bookId limit :pageSize offset :startIndex")
  Future<List<HadithEntity>> getPagingHadithsByBookId(int bookId, int pageSize, int startIndex);

  @Query("select exists(select * from hadith where bookId = :bookId and id = :id )")
  Future<bool?> getExistsHadithByBookId(int bookId, int id);


  //Hadith Topic Pagination Functions
  @Query("""
    select count(*) from Hadith H, HadithTopic HT where
    HT.hadithId=H.id and HT.topicId=:topicId
  """)
  Future<int?> getHadithCountByTopicId(int topicId);

  @Query("""
    select H.* from Hadith H, HadithTopic HT 
    where HT.hadithId=H.id and HT.topicId=:topicId limit :pageSize offset :startIndex
  """)
  Future<List<HadithEntity>> getPagingHadithsByTopicId(int topicId, int pageSize, int startIndex);

  @Query("""select exists(select H.* from Hadith H, HadithTopic HT 
    where HT.hadithId=H.id and HT.topicId = :topicId and id = :id )""")
  Future<bool?> getExistsHadithByTopicId(int topicId, int id);

  @Query("select name from topic where id = :topicId")
  Future<String?> getTopicName(int topicId);


  //Hadith List Pagination Functions
  @Query("""
    select count(*) from Hadith H,ListHadith LH
    where LH.hadithId=H.id and LH.listId=:listId
  """)
  Future<int?> getHadithCountByListId(int listId);

  @Query("""
    select H.* from Hadith H,ListHadith LH
    where LH.hadithId=H.id and LH.listId=:listId limit :pageSize offset :startIndex
  """)
  Future<List<HadithEntity>> getPagingHadithsByListId(int listId, int pageSize, int startIndex);

  @Query("""select exists(select H.* from Hadith H,ListHadith LH
    where LH.hadithId=H.id and LH.listId=:listId and id = :id )""")
  Future<bool?> getExistsHadithByListId(int listId, int id);


  //Hadith Search Pagination Functions
  @Query("""
    select count(*) from Hadith where lower(content) REGEXP lower(:regExp)
  """)
  Future<int?> getHadithCountByRegExp(String regExp);

  @Query("""
    select * from Hadith where lower(content) REGEXP lower(:regExp)
    limit :pageSize offset :startIndex
  """)
  Future<List<HadithEntity>> getPagingHadithsByRegExp(String regExp, int pageSize, int startIndex);



  //Common Functions
  @Query("select * from hadith where id=:id")
  Future<HadithEntity?> getHadithById(int id);

  @Query("""
    select count(*) from hadith where id<:id
  """)
  Future<int?> getPosById(int id);


  @Query("""select H.* from Hadith H,ListHadith LH
     where LH.hadithId=H.id and LH.listId=:listId order by
      LH.pos desc
     """)
  Future<List<HadithEntity>> getHadithsFromListId(int listId);


}
