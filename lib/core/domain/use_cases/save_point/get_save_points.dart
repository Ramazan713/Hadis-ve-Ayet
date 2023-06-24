

import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

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

}