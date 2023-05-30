

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
  Future<int?> getHadithCountByBookId(int bookId) async{
    return _hadithAllDao.getHadithCountByBookId(bookId);
  }

  @override
  Future<List<Hadith>> getPagingHadithsByBookId(int bookId, int pageSize, int startIndex) async{
    return (await _hadithAllDao.getPagingHadithsByBookId(bookId, pageSize, startIndex))
        .map((e) => e.toHadith()).toList();
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


}