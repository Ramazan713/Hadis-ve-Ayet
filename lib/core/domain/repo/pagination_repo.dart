
import 'package:meta/meta.dart';

import '../models/paging/i_paging_item.dart';

abstract class PaginationRepo<T extends IPagingItem>{

  Future<T?> getUpdatedItem(T item);

  Future<List<T>> getItems(int startIndex, int endIndex);

  Future<int> getTotalItems();

  Future<bool> isItemExists(T item);
}