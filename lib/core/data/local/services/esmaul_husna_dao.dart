

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/esmaul_husna_entity.dart';

@dao
abstract class EsmaulHusnaDao{

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEsmaulHusna(EsmaulHusnaEntity esmaulHusna);

  @Query("""
    select * from esmaulHusna order by orderItem
  """)
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnas();

  @Query("""
    select * from esmaulHusna order by orderItem
  """)
  Stream<List<EsmaulHusnaEntity>> getStreamEsmaulHusnas();

  @Query("""
    select * from esmaulHusna where id=:id order by orderItem
  """)
  Future<EsmaulHusnaEntity?> getEsmaulHusnaWithId(int id);

  @Query("""
    select * from esmaulHusna where 
    lower(name) Like lower(:query) or 
    lower(searchName) Like lower(:query) or 
    lower(meaning) Like lower(:query) or
    lower(virtue) Like lower(:query)
    order by orderItem
  """)
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnasSearchedLike(String query);

  @Query("""
     select * from esmaulHusna where 
     lower(name) REGEXP lower(:regExp) or
     lower(searchName) REGEXP lower(:regExp) or
     lower(meaning) REGEXP lower(:regExp) or
     lower(virtue) REGEXP lower(:regExp)
     order by orderItem
  """)
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnasSearchedRegEx(String regExp);

}