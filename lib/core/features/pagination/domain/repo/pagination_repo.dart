
import 'package:meta/meta.dart';

import '../models/i_paging_item.dart';

abstract class PaginationRepo<T extends IPagingItem, K>{

  Future<T?> getUpdatedItem(T item);

  Future<List<T>> getItems(int startIndex, int endIndex, int startPage, int endPage);

  Future<int> getTotalItems();

  Future<bool> isItemExists(T item);

  K groupBy(T item);
}