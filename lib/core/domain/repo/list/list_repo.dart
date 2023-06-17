

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';

abstract class ListRepo{

  Future<int> getMaxPosList();

  Future<int> getMaxPosListWithSourceType(SourceTypeEnum sourceType);

  Future<int> insertList(ListModel listModel);

  Future<void> updateList(ListModel listModel);

  Future<int> deleteList(ListModel listModel);

  Future<ListModel?> getFavoriteList(SourceTypeEnum sourceType);

  Future<String?> getListName(int listId);

}