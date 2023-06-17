

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/surah_entity.dart';

@dao
abstract class SurahDao{

  @Query("select * from surah")
  Future<List<SurahEntity>> getAllSurah();

  @Query("""
    select * from surah where name like :querySearchFull or searchName like :querySearchFull 
    order by (case when lower(searchName)=:queryRaw then 1 
    when searchName like :queryOrderForLike then 2 
    else 3 end)
    """)
  Future<List<SurahEntity>>getSurahesWithQuery(
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
  );

  @Query("""select * from Surah where id=:surahId""")
  Future<SurahEntity?>getSurah(int surahId);

  @Query("""
    select name from surah where id = :surahId
  """)
  Future<String?> getSurahNameById(int surahId);

}