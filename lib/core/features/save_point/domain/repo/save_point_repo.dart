

import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';

abstract class SavePointRepo{

  Future<int>insertSavePoint(SavePoint savePoint);

  Future<void>deleteSavePoint(SavePoint savePoint);

  Future<void>updateSavePoint(SavePoint savePoint);

  Future<SavePoint?> getSavePointById(int id);

  Stream<SavePoint?> getStreamSavePointById(int id);

  Future<void>deleteSavePointsWithQuery(SavePointType savePointType,String parentKey);

  Future<SavePoint?> getLastSavePointByDestinationAndAutoType(
      SavePointDestination destination, SaveAutoType autoType);

  Future<SavePoint?> getLastSavePointByBookScopeAndType(
      BookScopeEnum bookScope, SavePointType type, SaveAutoType autoType);

  Stream<List<SavePoint>> getStreamSavePointsWithScopes(List<BookScopeEnum> bookScopes);

  Stream<List<SavePoint>> getStreamSavePointsWithScopesAndTypeIds(List<BookScopeEnum> bookScopes, List<SavePointType> types);

  Stream<List<SavePoint>> getStreamSavePointsWithTypeIds(List<SavePointType> types);

  Stream<List<SavePoint>> getStreamSavePointsWithTypeIdsAndParentKey(List<SavePointType> types, String parentKey);
}