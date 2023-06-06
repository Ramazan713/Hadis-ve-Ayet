

import 'package:hadith/core/data/local/mapper/hadith_mapper.dart';
import 'package:hadith/core/data/local/services/hadith_all_dao.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_repo.dart';

class HadithRepoImpl extends HadithRepo{

  late final HadithAllDao _hadithAllDao;

  HadithRepoImpl({required HadithAllDao hadithAllDao}){
    _hadithAllDao = hadithAllDao;
  }

  @override
  Future<Hadith?> getHadithById(int id) async{
    return (await _hadithAllDao.getHadithById(id))?.toHadith();
  }

  @override
  Future<int?> getPosById(int id) async{
    return _hadithAllDao.getPosById(id);
  }

  @override
  Future<List<Hadith>> getHadithsFromListId(int listId) async{
    return (await _hadithAllDao.getHadithsFromListId(listId))
        .map((e) => e.toHadith()).toList();
  }



  @override
  Future<int> getHadithCountByBookId(int bookId) async{
    return (await _hadithAllDao.getHadithCountByBookId(bookId)) ?? 0;
  }

  @override
  Future<List<Hadith>> getPagingHadithsByBookId(int bookId, int pageSize, int startIndex) async{
    return (await _hadithAllDao.getPagingHadithsByBookId(bookId, pageSize, startIndex))
        .map((e) => e.toHadith()).toList();
  }


  @override
  Future<int> getHadithCountByTopicId(int topicId) async{
    return (await _hadithAllDao.getHadithCountByTopicId(topicId)) ?? 0;
  }

  @override
  Future<List<Hadith>> getPagingHadithsByTopicId(int topicId, int pageSize, int startIndex) async{
    return (await _hadithAllDao.getPagingHadithsByTopicId(topicId,pageSize,startIndex))
        .map((e) => e.toHadith()).toList();
  }



  @override
  Future<List<Hadith>> getPagingHadithsByListId(int listId, int pageSize, int startIndex) async{
    return (await _hadithAllDao.getPagingHadithsByListId(listId,pageSize,startIndex))
        .map((e) => e.toHadith()).toList();
  }

  @override
  Future<int> getHadithCountByListId(int listId) async{
    return (await _hadithAllDao.getHadithCountByListId(listId)) ?? 0;
  }




  @override
  Future<int> getHadithCountByQuery(String query) async{
    return (await _hadithAllDao.getHadithCountByRegExp(query)) ?? 0;
  }

  @override
  Future<List<Hadith>> getPagingHadithsByQuery(String query, int pageSize, int startIndex) async{
    return (await _hadithAllDao.getPagingHadithsByRegExp(query,pageSize,startIndex))
        .map((e) => e.toHadith()).toList();
  }

  @override
  Future<bool> getExistsHadithByBookId(int bookId, int id) async{
    return (await _hadithAllDao.getExistsHadithByBookId(bookId, id)) ?? false;
  }

  @override
  Future<bool> getExistsHadithByListId(int listId, int id) async{
    return (await _hadithAllDao.getExistsHadithByListId(listId, id)) ?? false;
  }

  @override
  Future<bool> getExistsHadithByTopicId(int topicId, int id) async{
    return (await _hadithAllDao.getExistsHadithByTopicId(topicId, id)) ?? false;
  }

  @override
  Future<String?> getListName(int listId) {
    return _hadithAllDao.getListName(listId);
  }

  @override
  Future<String?> getTopicName(int topicId) {
    return _hadithAllDao.getTopicName(topicId);
  }

}