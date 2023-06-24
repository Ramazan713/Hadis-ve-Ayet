


import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';

class InsertOrUpdateAutoSavePoint{

  late final SavePointRepo _savePointRepo;
  InsertOrUpdateAutoSavePoint({required SavePointRepo savePointRepo}){
    _savePointRepo = savePointRepo;
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
        itemIndexPos: itemIndexPos,
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