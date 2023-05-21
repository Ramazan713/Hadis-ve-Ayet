


import 'package:hadith/core/pagination/data/pagination_manager_impl.dart';
import 'package:hadith/core/pagination/domain/model/paging_config.dart';
import 'package:hadith/core/pagination/domain/enums/paging_invalidate_op.dart';
import 'package:hadith/core/pagination/domain/pagination_manager.dart';
import 'package:hadith/core/pagination/domain/pagination_repo.dart';
import 'package:hadith/features/hadiths/domain/hadith_list_model.dart';

abstract class IPaginationEvent{}

class PaginationEventInit extends IPaginationEvent{
  final PaginationRepo paginationRepo;
  final PagingConfig config;
  PaginationEventInit(this.paginationRepo,{required this.config});
}

class PaginationEventListenData  extends IPaginationEvent{}

class PaginationEventFetchNextPage extends IPaginationEvent{}

class PaginationEventFetchPreviousPage extends IPaginationEvent{
  final int firstPos;
  PaginationEventFetchPreviousPage({required this.firstPos});
}

class PaginationEventJumpToPage extends IPaginationEvent{
  final int page;
  PaginationEventJumpToPage({required this.page});
}

class PaginationEventJumpToPos extends IPaginationEvent{
  final int pos;
  PaginationEventJumpToPos({required this.pos});
}

class PaginationEventInValidate extends IPaginationEvent{
  final HadithListModel item;
  final PagingInvalidateOp op;
  PaginationEventInValidate({required this.item,required this.op});
}
