

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/use_cases/select_list/insert_or_delete_list.dart';

import 'get_favorite_list.dart';

class AddFavoriteList{
  late final GetFavoriteList _getFavoriteList;
  late final InsertOrDeleteListItem _insertOrDeleteListItem;

  AddFavoriteList({
    required GetFavoriteList getFavoriteList,
    required InsertOrDeleteListItem insertOrDeleteListItem,
  }){
    _getFavoriteList = getFavoriteList;
    _insertOrDeleteListItem = insertOrDeleteListItem;
  }


  Future<void> call({required int itemId, required SourceTypeEnum sourceType})async{
    final favList = await _getFavoriteList.call(sourceType: sourceType);

    await _insertOrDeleteListItem.call(itemId: itemId, listId: favList.id??0, sourceType: sourceType);
  }
}