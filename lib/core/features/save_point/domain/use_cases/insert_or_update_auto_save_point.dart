
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';

class InsertOrUpdateAutoSavePoint{

  late final SavePointRepo _savePointRepo;
  InsertOrUpdateAutoSavePoint({required SavePointRepo savePointRepo}){
    _savePointRepo = savePointRepo;
  }


  Future<void> callWithId({
    required int savePointId,
    required SavePointDestination destination,
    required int itemIndexPos,
    String? title,
    SaveAutoType? autoType,
    DateTime? dateTime,
  })async{

    final SavePoint? savePoint = await _savePointRepo.getSavePointById(savePointId);
    final modifiedDate = (dateTime ?? DateTime.now()).toIso8601String();

    if(savePoint!=null){
      final updatedSavePoint = savePoint.copyWith(
          autoType: autoType,
          itemIndexPos: itemIndexPos,
          title: title,
          destination: destination,
          modifiedDate: modifiedDate
      );
      await _savePointRepo.updateSavePoint(updatedSavePoint);
    }
  }

  Future<void> call({
    required SavePointDestination destination,
    required int itemIndexPos,
    String? title,
    SaveAutoType autoType = SaveAutoType.none,
    DateTime? dateTime,
  }) async{

    final SavePoint? savePoint = await _savePointRepo.getLastSavePointByBookScopeAndType(
        destination.getBookScope(),
        destination.getType(),
        autoType
    );

    final modifiedDate = (dateTime ?? DateTime.now()).toIso8601String();

    if(savePoint!=null){
      final updatedSavePoint = savePoint.copyWith(
        autoType: autoType,
        itemIndexPos: itemIndexPos,
        title: title,
        destination: destination,
        modifiedDate: modifiedDate
      );
      await _savePointRepo.updateSavePoint(updatedSavePoint);

    }else{
      final currentTitle = title ?? SavePoint.getAutoSavePointTitle(
          destination,
          date: modifiedDate,
          autoType: autoType,
      );
      final savePoint = SavePoint(
        itemPos: itemIndexPos,
        title: currentTitle,
        autoType: autoType,
        modifiedDate: modifiedDate,
        destination: destination,
        id: null
      );
      await _savePointRepo.insertSavePoint(savePoint);
    }
  }

}