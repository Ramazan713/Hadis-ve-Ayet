

import 'package:hadith/core/data/mapper/list/list_model_mapper.dart';
import 'package:hadith/core/data/local/services/list/list_dao.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';

class ListRepoImpl extends ListRepo{

  late final ListDao _listDao;

  ListRepoImpl({required ListDao listDao}){
    _listDao = listDao;
  }

  @override
  Future<int> deleteList(ListModel listModel) async{
    return await _listDao.deleteList(listModel.toListEntity());
  }

  @override
  Future<int> insertList(ListModel listModel) async{
    return await _listDao.insertList(listModel.toListEntity());
  }

  @override
  Future<void> updateList(ListModel listModel) async{
    await _listDao.updateList(listModel.toListEntity());
  }

  @override
  Future<int> getMaxPosListWithSourceType(SourceTypeEnum sourceType) async{
    return (await _listDao.getMaxPosListWithSourceId(sourceType.sourceId)) ?? 0;
  }

  @override
  Future<int> getMaxPosList() async{
    return (await _listDao.getMaxPosList()) ?? 0;
  }

  @override
  Future<ListModel?> getFavoriteList(SourceTypeEnum sourceType) async{
    return (await _listDao.getFavoriteList(sourceType.sourceId))?.toListModel();
  }

  @override
  Future<String?> getListName(int listId) {
    return _listDao.getListName(listId);
  }

  @override
  Future<ListModel?> getListById(int listId) async{
    return (await _listDao.getListById(listId))?.toListModel();
  }

}