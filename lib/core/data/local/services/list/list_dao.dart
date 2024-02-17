

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/list/list_entity.dart';

@dao
abstract class ListDao{

  @insert
  Future<int> insertList(ListEntity listEntity);

  @update
  Future<int> updateList(ListEntity listEntity);

  @delete
  Future<int> deleteList(ListEntity listEntity);


  @Query("""select ifnull(max(pos),0) data from lists where sourceId=:sourceId """)
  Future<int?> getMaxPosListWithSourceId(int sourceId);

  @Query("""select ifnull(max(pos),0) data from lists""")
  Future<int?>getMaxPosList();


  @Query("""
    select * from lists where isRemovable = 0 and sourceId = :sourceId
  """)
  Future<ListEntity?> getFavoriteList(int sourceId);

  @Query("""
    select * from lists where id = :listId
  """)
  Future<ListEntity?> getListById(int listId);

  @Query("select name from lists where id = :listId")
  Future<String?> getListName(int listId);

}