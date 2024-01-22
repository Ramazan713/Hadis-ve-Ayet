

import 'package:hadith/core/features/pagination/domain/enums/paging_invalidate_op.dart';
import 'package:hadith/core/features/pagination/domain/models/i_paging_item.dart';

class PagingModifiedItem<T extends IPagingItem>{
  final T item;
  final PagingInvalidateOp op;

  PagingModifiedItem({required this.item, required this.op});
}