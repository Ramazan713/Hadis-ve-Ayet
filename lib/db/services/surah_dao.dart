import 'package:floor/floor.dart';
import 'package:hadith/db/entities/surah.dart';


@dao
abstract class SurahDao{

  @Query("select * from surah")
  Future<List<Surah>> getAllSurah();

  @Query("""
    select * from surah where name like :query or searchName like :query 
    order by (case when searchName=:or1 then 1 when searchName like :or2 then 2 
    when searchName like :or3 then 3 else 4 end)""")
  Future<List<Surah>>getSearchedSurahes(String query,String or1,String or2,String or3);


  @Query("""select * from Surah where id=:surahId""")
  Future<Surah?>getSurah(int surahId);

}