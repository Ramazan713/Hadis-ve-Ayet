
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/entities/list_entity.dart';
import 'package:hadith/db/entities/list_hadith_entity.dart';
import 'package:hadith/db/entities/list_verse_entity.dart';
import 'package:hadith/db/entities/views/list_hadith_view.dart';
import 'package:hadith/db/entities/views/list_verse_view.dart';
import 'package:hadith/db/services/list_dao.dart';

class ListRepoOld{
  ListDaoOld listDao;
  ListRepoOld({required this.listDao});

  Stream<List<ListEntityOld>>getStreamList(int sourceId) =>
      listDao.getStreamList(sourceId);

  Stream<List<ListEntityOld>>getStreamListWithArchive(int sourceId,bool isArchive)=>
      listDao.getStreamListWithArchive(sourceId, isArchive);


  Stream<List<ListEntityOld>>getStreamRemovableList(int sourceId)=>
      listDao.getStreamRemovableList(sourceId);

  Stream<List<ListEntityOld>>getStreamRemovableListWithArchive(int sourceId,bool isArchive)=>
      listDao.getStreamRemovableListWithArchive(sourceId, isArchive);


  Future<IntData?>getContentMaxPosFromListHadith(int listId)=>
      listDao.getContentMaxPosFromListHadith(listId);

  Future<IntData?>getContentMaxPosFromListVerse(int listId)=>
      listDao.getContentMaxPosFromListVerse(listId);


  Future<IntData?>getMaxPosListWithSourceId(int sourceId)=>
      listDao.getMaxPosListWithSourceId(sourceId);

  Future<IntData?>getMaxPosList()=>listDao.getMaxPosList();


  Future<List<ListHadithEntityOld>>getHadithListWithHadithId(int hadithId)=>
      listDao.getHadithListWithHadithId(hadithId);

  Future<List<ListHadithEntityOld>>getHadithListWithHadithIdArchive(int hadithId,bool isArchive)=>
      listDao.getHadithListWithHadithIdArchive(hadithId, isArchive);


  Future<List<ListHadithEntityOld>>getHadithListWithRemovable(int hadithId,bool isRemovable)=>
      listDao.getHadithListWithRemovable(hadithId, isRemovable);

  Future<List<ListHadithEntityOld>>getHadithListWithRemovableArchive(int hadithId,
      bool isRemovable,bool isArchive)=>
      listDao.getHadithListWithRemovableArchive(hadithId, isRemovable, isArchive);



  Future<List<ListVerseEntityOld>>getVerseListWithListId(int listId)=>
      listDao.getVerseListWithListId(listId);

  Future<List<ListVerseEntityOld>>getVerseListWithVerseId(int verseId)=>
      listDao.getVerseListWithVerseId(verseId);

  Future<List<ListVerseEntityOld>>getVerseListWithVerseIdArchive(int verseId,bool isArchive)=>
      listDao.getVerseListWithVerseIdArchive(verseId, isArchive);


  Future<List<ListVerseEntityOld>>getVerseListWithRemovable(int verseId,bool isRemovable)=>
      listDao.getVerseListWithRemovable(verseId, isRemovable);

  Future<List<ListVerseEntityOld>>getVerseListWithRemovableArchive(int verseId,
      bool isRemovable,bool isArchive)=>
      listDao.getVerseListWithRemovableArchive(verseId, isRemovable, isArchive);



  Stream<List<ListHadithViewOld>> getListHadithViews(bool isArchive)=>
      listDao.getListHadithViews(isArchive);

  Stream<List<ListHadithViewOld>> getSearchResultHadithViews(String name,bool isArchive)=>
      listDao.getSearchResultHadithViews("%$name%",name,"$name%","%$name",isArchive);

  Stream<List<ListHadithViewOld>>getAllArchivedListViews()=>
      listDao.getAllArchivedListViews();

  Stream<List<ListVerseViewOld>> getListVerseViews(bool isArchive)=>
      listDao.getListVerseViews(isArchive);

  Stream<List<ListVerseViewOld>>getSearchResultVerseViews(String name,bool isArchive)=>
      listDao.getSearchResultVerseViews("%$name%",name,"$name%","%$name",isArchive);


  Future<List<ListHadithEntityOld>>getHadithListWithListId(int listId)=>
      listDao.getHadithListWithListId(listId);

  Future<int> insertList(ListEntityOld listEntity)=>listDao.insertList(listEntity);

  Future<int> updateList(ListEntityOld listEntity)=>listDao.updateList(listEntity);

  Future<int> deleteList(ListEntityOld listEntity)=>listDao.deleteList(listEntity);


  Future<int> insertHadithList(ListHadithEntityOld listHadithEntity)=>
      listDao.insertHadithList(listHadithEntity);

  Future<List<int>> insertHadithLists(List<ListHadithEntityOld> listHadithEntities)=>
      listDao.insertHadithLists(listHadithEntities);

  Future<int> updateHadithList(ListHadithEntityOld listHadithEntity)=>
      listDao.updateHadithList(listHadithEntity);

  Future<int> deleteHadithList(ListHadithEntityOld listHadithEntity)=>
      listDao.deleteHadithList(listHadithEntity);


  Future<int> insertVerseList(ListVerseEntityOld listVerseEntity)=>
      listDao.insertVerseList(listVerseEntity);

  Future<List<int>> insertVerseLists(List<ListVerseEntityOld> listVerseEntities)=>
      listDao.insertVerseLists(listVerseEntities);

  Future<int> updateVerseList(ListVerseEntityOld listVerseEntity)=>
      listDao.updateVerseList(listVerseEntity);

  Future<int> deleteVerseList(ListVerseEntityOld listVerseEntity)=>
      listDao.deleteVerseList(listVerseEntity);


  Future<void>deleteListHadithWithQuery(int listId)=>
      listDao.deleteListHadithWithQuery(listId);

  Future<void>deleteListVerseWithQuery(int listId)=>
      listDao.deleteListVerseWithQuery(listId);

  Future<int> deleteHadithLists(List<ListHadithEntityOld> listHadithEntities)=>
      listDao.deleteHadithLists(listHadithEntities);

  Future<int> deleteVerseLists(List<ListVerseEntityOld> listVerseEntities)=>
      listDao.deleteVerseLists(listVerseEntities);


  Future<IntData?>verseIsAddedToList(int verseId,bool isRemovable)=>
      listDao.verseIsAddedToList(verseId, isRemovable);

  Future<IntData?>verseIsAddedToListWithArchive(int verseId,bool isRemovable,bool isArchive)=>
      listDao.verseIsAddedToListWithArchive(verseId, isRemovable, isArchive);
}