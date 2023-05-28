

import 'package:hadith/core/data/local/mapper/list/list_hadith_mapper.dart';
import 'package:hadith/core/domain/models/list/list_hadith.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';

import '../../local/services/list/list_hadith_dao.dart';

class ListHadithRepoImpl extends ListHadithRepo{

  late final ListHadithDao _listHadithDao;

  ListHadithRepoImpl({required ListHadithDao listHadithDao}){
    _listHadithDao = listHadithDao;
  }

  @override
  Future<int> insertListHadith(ListHadith listHadith) async{
    return await _listHadithDao.insertListHadith(listHadith.toListHadithEntity());
  }

  @override
  Future<List<int>> insertListHadiths(List<ListHadith> listHadiths) async{
    return await _listHadithDao.insertListHadiths(listHadiths.map((e) => e.toListHadithEntity()).toList());
  }

  @override
  Future<int> updateListHadith(ListHadith listHadith) async{
    return await _listHadithDao.updateListHadith(listHadith.toListHadithEntity());
  }

  @override
  Future<int> deleteListHadith(ListHadith listHadith) async{
    return await _listHadithDao.deleteListHadith(listHadith.toListHadithEntity());
  }

  @override
  Future<int> deleteListHadiths(List<ListHadith> listHadiths) async{
    return await _listHadithDao.deleteListHadiths(listHadiths.map((e) => e.toListHadithEntity()).toList());
  }

  @override
  Future<List<ListHadith>> getListHadithsWithListId(int listId) async{
    return (await _listHadithDao.getListHadithsWithListId(listId))
        .map((e) => e.toListHadith()).toList();
  }


  @override
  Future<ListHadith?> getListHadith(int hadithId, int listId) async{
    return (await _listHadithDao.getListHadith(hadithId, listId))?.toListHadith();
  }

  @override
  Future<int> getMaxPos() async{
    return (await _listHadithDao.getMaxPos())??0;
  }

}