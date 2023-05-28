

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/list/list_hadith_entity.dart';

@dao
abstract class ListHadithDao{


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertListHadith(ListHadithEntity listHadithEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertListHadiths(List<ListHadithEntity> listHadithEntities);

  @update
  Future<int> updateListHadith(ListHadithEntity listHadithEntity);

  @delete
  Future<int> deleteListHadith(ListHadithEntity listHadithEntity);

  @delete
  Future<int> deleteListHadiths(List<ListHadithEntity> listHadithEntities);


  @Query("""select * from listHadith where hadithId = :hadithId and listId = :listId""")
  Future<ListHadithEntity?> getListHadith(int hadithId, int listId);

  @Query("""select ifnull(max(pos),0) from listHadith""")
  Future<int?> getMaxPos();


  @Query("""select * from listHadith where listId=:listId""")
  Future<List<ListHadithEntity>> getListHadithsWithListId(int listId);

}