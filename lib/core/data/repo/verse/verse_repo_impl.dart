
import 'package:hadith/core/data/local/services/verse/verse_dao.dart';
import 'package:hadith/core/data/repo/verse/get_verses.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';import 'package:hadith/core/domain/repo/verse/verse_repo.dart';

class VerseRepoImpl extends VerseRepo {

  late final VerseDao _verseDao;
  late final GetVerses _getVerses;

  VerseRepoImpl({
    required VerseDao verseDao,
    required GetVerses getVerses
  }){
    _verseDao = verseDao;
    _getVerses = getVerses;
  }


  @override
  Future<List<Verse>> getPagingVersesByCuzNo(int cuzNo, int pageSize, int startIndex) async{
    final verseEntities = await _verseDao.getPagingVersesByCuzNo(cuzNo, pageSize, startIndex);
    return _getVerses(verseEntities);
  }

  @override
  Future<int> getVerseCountByCuzNo(int cuzNo) async{
    return (await _verseDao.getVerseCountByCuzNo(cuzNo)) ?? 0;
  }

  @override
  Future<bool> getExistsVerseByCuzNo(int cuzNo, int id) async{
    return (await _verseDao.getExistsVerseByCuzNo(cuzNo, id)) ?? false;
  }



  @override
  Future<List<Verse>> getPagingVersesBySurahId(int surahId, int pageSize, int startIndex) async{
    final verseEntities = await _verseDao.getPagingVersesBySurahId(surahId, pageSize, startIndex);
    return _getVerses(verseEntities);
  }

  @override
  Future<int> getVerseCountBySurahId(int surahId) async {
    return (await _verseDao.getVerseCountBySurahId(surahId)) ?? 0;
  }

  @override
  Future<bool> getExistsVerseBySurahId(int surahId, int id) async{
    return (await _verseDao.getExistsVerseBySurahId(surahId, id)) ?? false;
  }



  @override
  Future<List<Verse>> getPagingVersesByPageNo(int pageNo) async{
    final verseEntities = await _verseDao.getPagingVersesByPageNo(pageNo);
    return _getVerses(verseEntities);
  }

  @override
  Future<int> getVerseCountByPageNo(int pageNo) async{
    return (await _verseDao.getVerseCountByPageNo()) ?? 0;
  }

  @override
  Future<bool> getExistsVerseByPageNo(int pageNo, int id) async{
    return (await _verseDao.getExistsVerseByPageNo(pageNo, id)) ?? false;
  }



  @override
  Future<List<Verse>> getPagingVersesByListId(int listId, int pageSize, int startIndex) async{
    final verseEntities = await _verseDao.getPagingVersesByListId(listId, pageSize, startIndex);
    return _getVerses(verseEntities);
  }

  @override
  Future<int> getVerseCountByListId(int listId) async{
    return (await _verseDao.getVerseCountByListId(listId)) ?? 0;
  }

  @override
  Future<bool> getExistsVerseByListId(int listId, int id) async{
    return (await _verseDao.getExistsVerseByListId(listId, id)) ?? false;
  }



  @override
  Future<List<Verse>> getPagingVersesByTopicId(int topicId, int pageSize, int startIndex) async{
    final verseEntities = await _verseDao.getPagingVersesByTopicId(topicId, pageSize, startIndex);
    return _getVerses(verseEntities);
  }

  @override
  Future<int> getVerseCountByTopicId(int topicId) async{
    return (await _verseDao.getVerseCountByTopicId(topicId)) ?? 0;
  }

  @override
  Future<bool> getExistsVerseByTopicId(int topicId, int id) async{
    return (await _verseDao.getExistsVerseByTopicId(topicId, id)) ?? false;
  }







  @override
  Future<int?> getPosById(int id){
    return _verseDao.getPosById(id);
  }

  @override
  Future<Verse?> getVerseById(int id) async{
    final verseEntity = await _verseDao.getVerseById(id);
    return _getVerses.getVerseByEntity(verseEntity);
  }



  @override
  Future<List<Verse>> getVersesByListId(int listId) async{
    final verseEntities = await _verseDao.getVersesFromListId(listId);
    return _getVerses(verseEntities);
  }

  @override
  Future<int?> getCuzPosById(int id, int cuzNo) {
    return _verseDao.getCuzPosById(id, cuzNo);
  }

  @override
  Future<int?> getSurahPosById(int id, int surahId) {
    return _verseDao.getSurahPosById(id, surahId);
  }


}