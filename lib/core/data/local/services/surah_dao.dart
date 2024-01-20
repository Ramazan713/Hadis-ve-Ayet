

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/surah_entity.dart';

@dao
abstract class SurahDao{

  @Query("select * from surahs")
  Future<List<SurahEntity>> getAllSurah();

  @Query("""
    select * from surahs where name like :querySearchFull or searchName like :querySearchFull 
    order by (case when lower(searchName)=:queryRaw then 1 
    when searchName like :queryOrderForLike then 2 
    else 3 end)
    """)
  Future<List<SurahEntity>> getSurahesWithQuery(
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
  );

  @Query("""select * from surahs where id=:surahId""")
  Future<SurahEntity?> getSurah(int surahId);

  @Query("""select S.* from Surahs S, Verses V where V.surahId = S.id and V.id = :mealId""")
  Future<SurahEntity?> getSurahFromMealId(int mealId);

  @Query("""
    select name from surahs where id = :surahId
  """)
  Future<String?> getSurahNameById(int surahId);

}