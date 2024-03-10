
import 'package:hadith/core/data/local/services/save_point_dao.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/features/save_point/data/mapper/save_point_mapper.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';

class SavePointRepoImpl extends SavePointRepo{

  late final SavePointDao _savePointDao;

  SavePointRepoImpl({required SavePointDao savePointDao}){
    _savePointDao = savePointDao;
  }

  @override
  Future<void> deleteSavePoint(SavePoint savePoint) async{
    await _savePointDao.deleteSavePoint(savePoint.toSavePointEntity());
  }

  @override
  Future<void> deleteSavePointsWithQuery(SavePointType savePointType, String parentKey) async{
    await _savePointDao.deleteSavePointsWithQuery(savePointType.typeId, parentKey);
  }

  @override
  Future<int> insertSavePoint(SavePoint savePoint) async{
    return await _savePointDao.insertSavePoint(savePoint.toSavePointEntity());
  }

  @override
  Future<void> updateSavePoint(SavePoint savePoint) async{
    await _savePointDao.updateSavePoint(savePoint.toSavePointEntity());
  }

  @override
  Stream<List<SavePoint>> getStreamSavePointsWithScopes(List<BookScopeEnum> bookScopes){
    return _savePointDao.getStreamSavePointsWithScopes(bookScopes.map((e) => e.binaryId).toList())
        .map((items) => items.map((e) => e.toSavePoint()).toList());
  }

  @override
  Stream<List<SavePoint>> getStreamSavePointsWithScopesAndTypeIds(List<BookScopeEnum> bookScopes, List<SavePointType> types){
    return _savePointDao.getStreamSavePointsWithScopesAndTypeId(
        bookScopes.map((e) => e.binaryId).toList(),
        types.map((e) => e.typeId).toList()
    ).map((items) => items.map((e) => e.toSavePoint()).toList());
  }

  @override
  Stream<List<SavePoint>> getStreamSavePointsWithTypeIds(List<SavePointType> types) {
    return _savePointDao.getStreamSavePointsWithTypeIds(types.map((e) => e.typeId).toList())
        .map((items) => items.map((e) => e.toSavePoint()).toList());
  }

  @override
  Stream<List<SavePoint>> getStreamSavePointsWithTypeIdsAndParentKey(List<SavePointType> types, String parentKey){
    return _savePointDao.getStreamSavePointsWithTypeIdAndParentKey(types.map((e) => e.typeId).toList(),parentKey)
        .map((items) => items.map((e) => e.toSavePoint()).toList());
  }

  @override
  Future<SavePoint?> getLastSavePointByBookScopeAndType(
      BookScopeEnum bookScope, SavePointType type, SaveAutoType autoType
  )async {
    return (await _savePointDao.getLastSavePointByBookScopeAndType(
        bookScope.binaryId,
        type.typeId,
        autoType.index
    ))?.toSavePoint();
  }

  @override
  Future<SavePoint?> getLastSavePointByDestinationAndAutoType(
      SavePointDestination destination, SaveAutoType autoType
  ) async{
    return (await _savePointDao.getLastSavePointByDestinationAndAutoType(
        destination.getBookScope().binaryId,
        destination.getType().typeId,
        destination.getParentKey(),
        autoType.index
    ))?.toSavePoint();
  }

  @override
  Future<SavePoint?> getSavePointById(int id) async{
    return (await _savePointDao.getSavePointById(id))?.toSavePoint();
  }

  @override
  Stream<SavePoint?> getStreamSavePointById(int id) {
    return _savePointDao.getStreamSavePointById(id)
        .map((e) => e?.toSavePoint());
  }

}