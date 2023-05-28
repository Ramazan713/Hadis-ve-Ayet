import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';

class DeleteSavePoint{

  late final SavePointRepo _savePointRepo;
  DeleteSavePoint({required SavePointRepo savePointRepo}){
    _savePointRepo = savePointRepo;
  }


  Future<void> call(SavePoint savePoint) async{
    await _savePointRepo.deleteSavePoint(savePoint);
  }


}