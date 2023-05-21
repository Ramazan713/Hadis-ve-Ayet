

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/hadith.dart';

@dao
abstract class HadithAllDao{

  @Query("select count(*) data from hadith")
  Future<int?> getAllHadithCount();

  @Query("select * from hadith limit :pageSize offset :startIndex")
  Future<List<Hadith>> getPagingAllHadiths(int pageSize,int startIndex);


  @Query("select * from hadith where id=:id")
  Future<Hadith?> getHadithById(int id);

  @Query("""
    select count(*) from hadith where id<:id
  """)
  Future<int?> getPosById(int id);


  @Query("""select exists (select LH.* from listHadith LH,List L where 
    LH.listId=L.id and LH.hadithId=:hadithId and L.isRemovable=:isRemovable)""")
  Stream<bool?> isHadithInList(int hadithId, bool isRemovable);





}
