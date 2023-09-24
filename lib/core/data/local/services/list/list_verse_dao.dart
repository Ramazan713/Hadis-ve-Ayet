

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/list/list_verse_entity.dart';

@dao
abstract class ListVerseDao{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertListVerse(ListVerseEntity listVerseEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertListVerses(List<ListVerseEntity> listVerseEntities);

  @update
  Future<int> updateListVerse(ListVerseEntity listVerseEntity);

  @delete
  Future<int> deleteListVerse(ListVerseEntity listVerseEntity);

  @delete
  Future<int> deleteListVerses(List<ListVerseEntity> listVerseEntities);


  @Query("""
    select * from listVerses where verseId = :verseId and listId = :listId
  """)
  Future<ListVerseEntity?> getListVerse(int verseId, int listId);

  @Query("""
    select ifnull(max(pos),0) from listVerses
  """)
  Future<int?> getMaxPos();

  @Query("""select * from listVerses where listId=:listId""")
  Future<List<ListVerseEntity>> getListVersesWithListId(int listId);


  @Query("""
    select listId from listVerses where verseId = :verseId
  """)
  Future<List<int>> getListIdsFromVerseId(int verseId);

}