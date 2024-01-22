
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';

class UpdateSavePoint{

  late final SavePointRepo _savePointRepo;
  UpdateSavePoint({required SavePointRepo savePointRepo}){
    _savePointRepo = savePointRepo;
  }


  Future<void> call(SavePoint updatedSavePoint) async{
    final date = DateTime.now().toIso8601String();
    _savePointRepo.updateSavePoint(updatedSavePoint.copyWith(modifiedDate: date));
  }




}