

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/hadith_entity.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';


@dao
abstract class SearchDao{

  //All Hadiths
  //By using Regex
  @Query("""select count(id) from Hadith where lower(content) REGEXP lower(:regExp)""")
  Future<int?> getCountAllHadithByRegex(String regExp);

  @Query("""
    select * from Hadith where lower(content) REGEXP lower(:regExp)
    limit :pageSize offset :startIndex
  """)
  Future<List<HadithEntity>> getAllHadithByRegex(String regExp, int pageSize, int startIndex);


  //By using Like
  @Query("""select count(id) from Hadith where lower(content) Like lower(:query)""")
  Future<int?> getCountAllHadithByLike(String query);

  @Query("""
    select * from Hadith where lower(content) Like lower(:query)
    limit :pageSize offset :startIndex
  """)
  Future<List<HadithEntity>> getAllHadithsByLike(String query, int pageSize, int startIndex);



  //Hadith Books
  //By using Regex
  @Query("""select count(id) from Hadith where bookId=:bookId and lower(content) REGEXP lower(:regExp)""")
  Future<int?> getCountHadithByRegexAndBookId(int bookId, String regExp);

  @Query("""
    select * from Hadith where bookId=:bookId and lower(content) REGEXP lower(:regExp) 
    limit :pageSize offset :startIndex
  """)
  Future<List<HadithEntity>> getHadithsByRegexAndBookId(int bookId, String regExp, int pageSize, int startIndex);


  //By using Like
  @Query("""select count(id) from Hadith where bookId=:bookId and lower(content) Like lower(:query)""")
  Future<int?> getCountHadithByLikeAndBookId(int bookId, String query);

  @Query("""
    select * from Hadith where bookId=:bookId and lower(content) Like lower(:query) 
    limit :pageSize offset :startIndex
  """)
  Future<List<HadithEntity>> getHadithsByLikeAndBookId(int bookId, String query, int pageSize, int startIndex);




  //Verses
  //By using Regex
  @Query("""select count(id) data from verse V where lower(content)  REGEXP lower(:regExp) """)
  Future<int?> getCountVerseByRegex(String regExp);

  @Query("""
    select * from verse where lower(content)  REGEXP lower(:regExp)
    limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getVersesByRegex(String regExp, int pageSize, int startIndex);


  //By using Like
  @Query("""select count(id) data from verse V where lower(content) Like lower(:query) """)
  Future<int?> getCountVerseByLike(String query);

  @Query("""
    select * from verse where lower(content)  Like lower(:query)
    limit :pageSize offset :startIndex
  """)
  Future<List<VerseEntity>> getVersesByLike(String query, int pageSize, int startIndex);






}