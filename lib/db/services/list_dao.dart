import 'package:floor/floor.dart';
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/entities/list_entity.dart';
import 'package:hadith/db/entities/list_hadith_entity.dart';
import 'package:hadith/db/entities/list_verse_entity.dart';
import 'package:hadith/db/entities/views/list_hadith_view.dart';
import 'package:hadith/db/entities/views/list_verse_view.dart';


@dao
abstract class ListDaoOld{

  @Query("select * from list where sourceId=:sourceId order by isRemovable asc,pos desc")
  Stream<List<ListEntityOld>>getStreamList(int sourceId);

  @Query("select * from list where sourceId=:sourceId and isArchive=:isArchive order by isRemovable asc,pos desc")
  Stream<List<ListEntityOld>>getStreamListWithArchive(int sourceId,bool isArchive);


  @Query("""select * from list where sourceId=:sourceId and isRemovable=1 order by pos desc""")
  Stream<List<ListEntityOld>>getStreamRemovableList(int sourceId);

  @Query("""select * from list where sourceId=:sourceId and isRemovable=1 and
   isArchive=:isArchive order by pos desc""")
  Stream<List<ListEntityOld>>getStreamRemovableListWithArchive(int sourceId,bool isArchive);


  @Query("""select * from listHadith where listId=:listId""")
  Future<List<ListHadithEntityOld>>getHadithListWithListId(int listId);

  @Query("""select * from listHadith where hadithId=:hadithId""")
  Future<List<ListHadithEntityOld>>getHadithListWithHadithId(int hadithId);

  @Query("""select * from listHadith where hadithId=:hadithId and isArchive=:isArchive""")
  Future<List<ListHadithEntityOld>>getHadithListWithHadithIdArchive(int hadithId,bool isArchive);


  @Query("""select LH.* from listHadith LH,List L where 
    LH.listId=L.id and LH.hadithId=:hadithId and L.isRemovable=:isRemovable""")
  Future<List<ListHadithEntityOld>>getHadithListWithRemovable(int hadithId,bool isRemovable);

  @Query("""select LH.* from listHadith LH,List L where isArchive=:isArchive and
    LH.listId=L.id and LH.hadithId=:hadithId and L.isRemovable=:isRemovable""")
  Future<List<ListHadithEntityOld>>getHadithListWithRemovableArchive(int hadithId,
      bool isRemovable,bool isArchive);


  @Query("""select * from listVerse where listId=:listId""")
  Future<List<ListVerseEntityOld>>getVerseListWithListId(int listId);

  @Query("""select * from listVerse where verseId=:verseId""")
  Future<List<ListVerseEntityOld>>getVerseListWithVerseId(int verseId);

  @Query("""select * from listVerse where verseId=:verseId and isArchive=:isArchive""")
  Future<List<ListVerseEntityOld>>getVerseListWithVerseIdArchive(int verseId,bool isArchive);


  @Query("""select LV.* from listVerse LV,List L where
    LV.listId=L.id and LV.verseId=:verseId and L.isRemovable=:isRemovable""")
  Future<List<ListVerseEntityOld>>getVerseListWithRemovable(int verseId,bool isRemovable);

  @Query("""select LV.* from listVerse LV,List L where isArchive=:isArchive and
    LV.listId=L.id and LV.verseId=:verseId and L.isRemovable=:isRemovable""")
  Future<List<ListVerseEntityOld>>getVerseListWithRemovableArchive(int verseId,
      bool isRemovable,bool isArchive);

  @Query("""select exists(select 1 from listVerse LV,List L where
    LV.listId=L.id and LV.verseId=:verseId and L.isRemovable=:isRemovable) data""")
  Future<IntData?>verseIsAddedToList(int verseId,bool isRemovable);

  @Query("""select exists(select 1 from listVerse LV,List L where isArchive=:isArchive and
    LV.listId=L.id and LV.verseId=:verseId and L.isRemovable=:isRemovable) data""")
  Future<IntData?>verseIsAddedToListWithArchive(int verseId,
      bool isRemovable,bool isArchive);

  
  @Query("""select contentMaxPos data from listHadithView where id=:listId """)
  Future<IntData?>getContentMaxPosFromListHadith(int listId);

  @Query("""select contentMaxPos data from listVerseView where id=:listId""")
  Future<IntData?>getContentMaxPosFromListVerse(int listId);

  @Query("""select max(pos) data from list where sourceId=:sourceId """)
  Future<IntData?>getMaxPosListWithSourceId(int sourceId);

  @Query("""select max(pos) data from list """)
  Future<IntData?>getMaxPosList();



  @Query("select * from listHadithView where isArchive=:isArchive order by isRemovable asc,listPos desc")
  Stream<List<ListHadithViewOld>> getListHadithViews(bool isArchive);

  @Query("""select * from listHadithView where isArchive=:isArchive and
     name like :name order by 
     (case when name=:or1 then 1 when name like :or2 then 2 when name like :or3
      then 3 else 4 end ),listPos desc""")
  Stream<List<ListHadithViewOld>> getSearchResultHadithViews(String name,
      String or1,String or2,String or3,bool isArchive);


  @Query("""select * from listHadithView  where isArchive=1 union 
      select * from listVerseView where isArchive=1 order by isRemovable asc,listPos desc""")
  Stream<List<ListHadithViewOld>>getAllArchivedListViews();

  @Query("select * from listVerseView where isArchive=:isArchive order by isRemovable asc,listPos desc")
  Stream<List<ListVerseViewOld>> getListVerseViews(bool isArchive);



  @Query("""select * from listVerseView where isArchive=:isArchive and
     name like :name order by 
     (case when name=:or1 then 1 when name like :or2 then 2 when name like :or3
      then 3 else 4 end )""")
  Stream<List<ListVerseViewOld>> getSearchResultVerseViews(String name,
      String or1,String or2,String or3,bool isArchive);


  @Query("""delete from listHadith where listId=:listId""")
  Future<void>deleteListHadithWithQuery(int listId);

  @Query("""delete from listVerse where listId=:listId""")
  Future<void>deleteListVerseWithQuery(int listId);


  @insert
  Future<int> insertList(ListEntityOld listEntity);

  @update
  Future<int> updateList(ListEntityOld listEntity);

  @delete
  Future<int> deleteList(ListEntityOld listEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertHadithList(ListHadithEntityOld listHadithEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertHadithLists(List<ListHadithEntityOld> listHadithEntities);

  @update
  Future<int> updateHadithList(ListHadithEntityOld listHadithEntity);

  @delete
  Future<int> deleteHadithList(ListHadithEntityOld listHadithEntity);

  @delete
  Future<int> deleteHadithLists(List<ListHadithEntityOld> listHadithEntities);



  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertVerseList(ListVerseEntityOld listVerseEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertVerseLists(List<ListVerseEntityOld> listVerseEntities);

  @update
  Future<int> updateVerseList(ListVerseEntityOld listVerseEntity);

  @delete
  Future<int> deleteVerseList(ListVerseEntityOld listVerseEntity);

  @delete
  Future<int> deleteVerseLists(List<ListVerseEntityOld> listVerseEntities);


}

