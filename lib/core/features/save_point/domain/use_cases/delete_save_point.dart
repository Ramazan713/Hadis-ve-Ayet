
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';

class DeleteSavePoint{

  late final SavePointRepo _savePointRepo;
  DeleteSavePoint({required SavePointRepo savePointRepo}){
    _savePointRepo = savePointRepo;
  }


  Future<void> call(SavePoint savePoint) async{
    await _savePointRepo.deleteSavePoint(savePoint);
  }


}