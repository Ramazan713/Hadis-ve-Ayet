

import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';

class HadithInvalidateEventModel{
  final HadithListModel item;
  final PagingInvalidateOp op;

  HadithInvalidateEventModel({required this.item,required this.op});
}