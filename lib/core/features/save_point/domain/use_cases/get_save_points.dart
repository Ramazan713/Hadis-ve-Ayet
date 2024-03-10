
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
    List<SavePointType> types = const []
  }) {
    if(types.isNotEmpty){
      return _savePointRepo.getStreamSavePointsWithScopesAndTypeIds(scopes, types);
    }
    return _savePointRepo.getStreamSavePointsWithScopes(scopes);
  }

  Stream<List<SavePoint>> callType({
    required BookScopeEnum? bookScope,
    required List<SavePointType> types
  }) {
    if(bookScope != null){
      return _savePointRepo.getStreamSavePointsWithScopesAndTypeIds([bookScope], types);
    }
    return _savePointRepo.getStreamSavePointsWithTypeIds(types);
  }

  Stream<List<SavePoint>> callParentKey({
    required List<SavePointType> types,
    required String parentKey
  }) {
    return _savePointRepo.getStreamSavePointsWithTypeIdsAndParentKey(types, parentKey);
  }

  Future<SavePoint?> callByIdSingle({required int id})async{
    return _savePointRepo.getSavePointById(id);
  }

  Stream<SavePoint?> callById({required int id}){
    return _savePointRepo.getStreamSavePointById(id);
  }

}