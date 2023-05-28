

import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';

abstract class SavePointRepo{

  Future<int>insertSavePoint(SavePoint savePoint);

  Future<void>deleteSavePoint(SavePoint savePoint);

  Future<void>updateSavePoint(SavePoint savePoint);

  Future<void>deleteSavePointsWithQuery(OriginTag savePointType,String parentKey);

  Stream<List<SavePoint>> getStreamSavePointsWithScopes(List<BookScopeEnum> bookScopes);

  Stream<List<SavePoint>> getStreamSavePointsWithScopesAndTypeId(List<BookScopeEnum> bookScopes, SavePointType type);

}