

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/esmaul_husna_entity.dart';

@dao
abstract class EsmaulHusnaDao{

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEsmaulHusna(EsmaulHusnaEntity esmaulHusna);

  @Query("""
    select * from esmaulHusnas order by orderItem
  """)
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnas();

  @Query("""
    select * from esmaulHusnas where orderItem = :orderItem
  """)
  Future<EsmaulHusnaEntity?> getEsmaulHusnaByOrderItem(int orderItem);

  @Query("""
    select * from esmaulHusnas order by orderItem
  """)
  Stream<List<EsmaulHusnaEntity>> getStreamEsmaulHusnas();

  @Query("""
    select * from esmaulHusnas where id=:id order by orderItem
  """)
  Future<EsmaulHusnaEntity?> getEsmaulHusnaWithId(int id);

  @Query("""
    select * from esmaulHusnas where 
    lower(name) Like lower(:query) or 
    lower(searchName) Like lower(:query) or 
    lower(meaning) Like lower(:query) or
    lower(virtue) Like lower(:query)
    order by orderItem
  """)
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnasSearchedLike(String query);

  @Query("""
    select * from esmaulHusnas where 
    lower(name) Like lower(:query) or 
    lower(searchName) Like lower(:query) or 
    lower(meaning) Like lower(:query) or
    lower(virtue) Like lower(:query)
    order by orderItem
  """)
  Stream<List<EsmaulHusnaEntity>> getStreamEsmaulHusnasSearchedLike(String query);

  @Query("""
     select * from esmaulHusnas where 
     lower(name) REGEXP lower(:regExp) or
     lower(searchName) REGEXP lower(:regExp) or
     lower(meaning) REGEXP lower(:regExp) or
     lower(virtue) REGEXP lower(:regExp)
     order by orderItem
  """)
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnasSearchedRegEx(String regExp);

  @Query("""
     select * from esmaulHusnas where 
     lower(name) REGEXP lower(:regExp) or
     lower(searchName) REGEXP lower(:regExp) or
     lower(meaning) REGEXP lower(:regExp) or
     lower(virtue) REGEXP lower(:regExp)
     order by orderItem
  """)
  Stream<List<EsmaulHusnaEntity>> getStreamEsmaulHusnasSearchedRegEx(String regExp);

}