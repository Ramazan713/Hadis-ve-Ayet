

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/use_cases/select_list/insert_or_delete_list.dart';

class AddFavoriteList{
  late final ListRepo _listRepo;
  late final InsertOrDeleteListItem _insertOrDeleteListItem;

  AddFavoriteList({
    required ListRepo listRepo,
    required InsertOrDeleteListItem insertOrDeleteListItem,
  }){
    _listRepo = listRepo;
    _insertOrDeleteListItem = insertOrDeleteListItem;
  }


  Future<void> call({required int itemId, required SourceTypeEnum sourceType})async{
    final favListId = await _getOrCreateFavoriteList(sourceType);

    await _insertOrDeleteListItem.call(itemId: itemId, listId: favListId, sourceType: sourceType);
  }

  Future<int> _getOrCreateFavoriteList(SourceTypeEnum sourceType)async{
    final listFav = await _listRepo.getFavoriteList(sourceType);
    if(listFav != null) return listFav.id??0;

    final listModel = ListModel(
        name: "Favoriler",
        isRemovable: false,
        isArchive: false,
        id: null,
        sourceType: sourceType,
        pos: 0,
    );
    final favListId = await _listRepo.insertList(listModel);
    return favListId;
  }


}