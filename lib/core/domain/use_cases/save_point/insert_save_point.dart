

import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';
import 'package:hadith/core/domain/enums/save_point/save_auto_type.dart';

class InsertSavePoint{

  late final SavePointRepo _savePointRepo;
  InsertSavePoint({required SavePointRepo savePointRepo}){
    _savePointRepo = savePointRepo;
  }


  Future<void> call({
    required SavePointDestination destination,
    required int position,
    required String title,
    SaveAutoType autoType = SaveAutoType.none,
    required DateTime dateTime
  }) async{

    final savePoint = SavePoint(
        itemIndexPos: position,
        title: title,
        autoType: autoType,
        modifiedDate: dateTime.toIso8601String(),
        destination: destination,
        id: null
    );

    await _savePointRepo.insertSavePoint(savePoint);

  }


}