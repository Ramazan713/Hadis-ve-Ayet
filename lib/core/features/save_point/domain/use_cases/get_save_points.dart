
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';

class GetSavePoints{

  late final SavePointRepo _savePointRepo;
  GetSavePoints({required SavePointRepo savePointRepo}){
    _savePointRepo = savePointRepo;
  }

  Stream<List<SavePoint>> callBook({
    required List<BookScopeEnum> scopes,
    SavePointType? type
  }) {
    if(type!=null){
      return _savePointRepo.getStreamSavePointsWithScopesAndTypeId(scopes, type);
    }
    return _savePointRepo.getStreamSavePointsWithScopes(scopes);
  }

  Stream<List<SavePoint>> callType({
    required BookScopeEnum? bookScope,
    required SavePointType type
  }) {
    if(bookScope!=null){
      return _savePointRepo.getStreamSavePointsWithScopesAndTypeId([bookScope], type);
    }
    return _savePointRepo.getStreamSavePointsWithTypeId(type);
  }

  Stream<List<SavePoint>> callParentKey({
    required SavePointType type,
    required String parentKey
  }) {
    return _savePointRepo.getStreamSavePointsWithTypeIdAndParentKey(type, parentKey);
  }

  Future<SavePoint?> callByIdSingle({required int id})async{
    return _savePointRepo.getSavePointById(id);
  }

  Stream<SavePoint?> callById({required int id}){
    return _savePointRepo.getStreamSavePointById(id);
  }

}