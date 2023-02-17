
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';
import 'package:hadith/db/services/save_point_dao.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/save_point/constants/save_point_constant.dart';
import 'package:hadith/features/save_point/save_point_param.dart';
import 'package:hadith/models/save_point_argument.dart';
import 'package:hadith/utils/save_point_helper.dart';

class SavePointRepo{
  final SavePointDao savePointDao;
  SavePointRepo({required this.savePointDao});

  Future<int>insertSavePoint(SavePoint savePoint)=>savePointDao.insertSavePoint(savePoint.toSavePointEntity());
  Future<int>deleteSavePoint(SavePoint savePoint)=>savePointDao.deleteSavePoint(savePoint.toSavePointEntity());
  Future<int>updateSavePoint(SavePoint savePoint)=>savePointDao.updateSavePoint(savePoint.toSavePointEntity());

  Future<SavePoint?> getAutoSavePoint(OriginTag originTag,String parentKey,{SaveAutoType autoType = SaveAutoType.general})async{
    return (await savePointDao.getSavePoint(originTag.savePointId, parentKey,autoType.index))?.toSavePoint();
  }

  Future<SavePoint?> getSavePoint(int savePointType,String parentKey) async{
    return (await savePointDao.getSavePoint(savePointType, parentKey,SaveAutoType.none.index))?.toSavePoint();
  }

  Stream<List<SavePoint>>getStreamSavePoints(OriginTag originTag,String parentKey)=>
      savePointDao.getStreamSavePoints(originTag.savePointId, parentKey)
          .map((event) => event.map((e) => e.toSavePoint()).toList());

  Future<SavePoint?> getAutoSavePointWithBookIdBinary(int savePointType,BookScopeEnum bookScope,
      {SaveAutoType autoType = SaveAutoType.general})async{
    return (await savePointDao.getAutoSavePointWithBookIdBinary(savePointType, bookScope.binaryId,autoType.index))?.toSavePoint();
  }

  Stream<List<SavePoint>>getStreamSavePointsWithBookIdBinary(int savePointType,BookScopeEnum bookScope)=>
      savePointDao.getStreamSavePointsWithBookIdBinary(savePointType, bookScope.binaryId)
          .map((event) => event.map((e) => e.toSavePoint()).toList());


  Stream<List<SavePoint>>getStreamSavePointsWithBook(List<BookScopeEnum> bookScopes)=>
      savePointDao.getStreamSavePointsWithBook(bookScopes.map((e) => e.binaryId).toList())
          .map((event) => event.map((e) => e.toSavePoint()).toList());

  Stream<List<SavePoint>>getStreamSavePointsWithBookFilter(List<BookScopeEnum> bookScopes, int savePointType)=>
      savePointDao.getStreamSavePointsWithBookFilter(bookScopes.map((e) => e.binaryId).toList(), savePointType)
          .map((event) => event.map((e) => e.toSavePoint()).toList());


  Future<SavePoint?> getSavePointWithId(int id)async{
    return (await savePointDao.getSavePointWithId(id))?.toSavePoint();
  }

  Future<void>deleteSavePointWithQuery(int savePointType,String parentKey)=>
      savePointDao.deleteSavePointWithQuery(savePointType, parentKey);

  Future<void>saveOrReplaceAutoSavePoint(SavePointParam savePointParam,SaveAutoType autoType)async{

    final date=DateTime.now();

    final SavePoint savePoint;

    final wideSavePointScope = kSavePointScopeOrigins.contains(savePointParam.originTag);

    final prevSavePointLoader=wideSavePointScope?
    savePointDao.getAutoSavePointWithBookIdBinary(savePointParam.originTag.savePointId,
        savePointParam.bookScope.binaryId,autoType.index):
    savePointDao.getSavePoint(savePointParam.originTag.savePointId,savePointParam.parentKey,autoType.index);
    final prevSavePoint=await prevSavePointLoader;

    if(prevSavePoint!=null){
      savePoint=prevSavePoint.toSavePoint().copyWith(itemIndexPos: savePointParam.itemIndexPos,
          parentKey: savePointParam.parentKey,
          parentName: savePointParam.parentName,
          modifiedDate: date.toIso8601String());
    }else{
      final title = SavePointHelper.getAutoSavePointTitle(savePointParam, date.toString(), autoType);
      savePoint = savePointParam.toSavePoint(title, autoType, date.toIso8601String());
    }

    await savePointDao.insertSavePoint(savePoint.toSavePointEntity());
  }


  Future<SavePoint?> loadSavePoint(SavePointLoadArg savePointArg,OriginTag originTag)async{

    if(savePointArg.loadNearPoint){
      return getSavePoint(originTag.savePointId, savePointArg.parentKey);
    } else if(savePointArg.id!=null){
      return (await savePointDao.getSavePointWithId(savePointArg.id??0))?.toSavePoint();
    }else{
      return getAutoSavePoint(originTag,savePointArg.parentKey);
    }
  }

  Future<SavePoint?> loadSavePointWithId(int savePointId)async{
    return (await savePointDao.getSavePointWithId(savePointId))?.toSavePoint();
  }

  Future<void> updateSavePointWithAutoDate(SavePoint savePoint)async{
    final date=DateTime.now();
    final newSavepoint = savePoint.copyWith(modifiedDate: date.toIso8601String());
    await savePointDao.updateSavePoint(newSavepoint.toSavePointEntity());
  }

}