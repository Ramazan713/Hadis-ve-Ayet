
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'insert_or_delete_list.dart';


class AddList {
  late final InsertOrDeleteListItem _insertOrDeleteListItem;

  AddList({
    required InsertOrDeleteListItem insertOrDeleteListItem,
  }) {
    _insertOrDeleteListItem = insertOrDeleteListItem;
  }

  Future<void> call({required ListViewModel listViewModel, required int itemId}) async{
    await _insertOrDeleteListItem.call(
        itemId: itemId,
        listId: listViewModel.id,
        sourceType: listViewModel.sourceType
    );
  }
}