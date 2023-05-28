import 'copy_list.dart';
import 'delete_items_in_list.dart';
import 'delete_list.dart';
import 'get_lists.dart';
import 'insert_list.dart';
import 'search_lists.dart';
import 'update_list.dart';

class ListUseCases{
  final CopyList copyList;
  final DeleteList deleteList;
  final InsertList insertList;
  final UpdateList updateList;
  final GetLists getLists;
  final SearchLists searchLists;
  final DeleteItemsInList deleteItemsInList;

  ListUseCases({required this.insertList,required this.updateList, required this.deleteItemsInList,
    required this.deleteList,required this.copyList,required this.getLists,required this.searchLists});
}