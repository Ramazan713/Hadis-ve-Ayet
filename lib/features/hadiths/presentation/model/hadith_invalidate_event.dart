

import 'package:hadith/core/features/pagination/domain/enums/paging_invalidate_op.dart';
import 'package:hadith/features/hadiths/domain/hadith_list_model.dart';

class HadithInvalidateEvent{
  final HadithListModel item;
  final PagingInvalidateOp op;

  HadithInvalidateEvent({required this.item,required this.op});
}