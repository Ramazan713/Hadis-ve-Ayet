

import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/core/domain/models/paging/i_paging_item.dart';

class PagingModifiedItem<T extends IPagingItem>{
  final T item;
  final PagingInvalidateOp op;

  PagingModifiedItem({required this.item, required this.op});
}