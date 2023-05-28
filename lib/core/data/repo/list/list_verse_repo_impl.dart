

import 'package:hadith/core/data/local/mapper/list/list_verse_mapper.dart';
import 'package:hadith/core/data/local/services/list/list_verse_dao.dart';
import 'package:hadith/core/domain/models/list/list_verse.dart';
import 'package:hadith/core/domain/repo/list/list_verse_repo.dart';

class ListVerseRepoImpl extends ListVerseRepo{

  late final ListVerseDao _listVerseDao;

  ListVerseRepoImpl({required ListVerseDao listVerseDao}){
    _listVerseDao = listVerseDao;
  }


  @override
  Future<int> insertListVerse(ListVerse listVerse) async{
    return await _listVerseDao.insertListVerse(listVerse.toListVerseEntity());
  }

  @override
  Future<List<int>> insertListVerses(List<ListVerse> listVerses) async{
    return await _listVerseDao.insertListVerses(listVerses.map((e) => e.toListVerseEntity()).toList());
  }

  @override
  Future<int> updateListVerse(ListVerse listVerse) async{
    return await _listVerseDao.updateListVerse(listVerse.toListVerseEntity());
  }

  @override
  Future<int> deleteListVerse(ListVerse listVerse) async{
    return await _listVerseDao.deleteListVerse(listVerse.toListVerseEntity());
  }

  @override
  Future<int> deleteListVerses(List<ListVerse> listVerses) async{
    return await _listVerseDao.deleteListVerses(listVerses.map((e) => e.toListVerseEntity()).toList());
  }




  @override
  Future<List<ListVerse>> getListVersesWithListId(int listId) async{
    return (await _listVerseDao.getListVersesWithListId(listId))
        .map((e) => e.toListVerse()).toList();
  }

  @override
  Future<ListVerse?> getListVerse(int verseId, int listId) async{
    return (await _listVerseDao.getListVerse(verseId, listId))?.toListVerse();
  }

  @override
  Future<int> getMaxPos() async{
    return (await _listVerseDao.getMaxPos())??0;
  }

}