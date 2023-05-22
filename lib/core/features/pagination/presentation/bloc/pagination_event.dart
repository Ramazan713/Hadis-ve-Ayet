import 'package:hadith/features/hadiths/domain/hadith_list_model.dart';

import '../../domain/enums/paging_invalidate_op.dart';
import '../../domain/model/paging_config.dart';
import '../../domain/pagination_repo.dart';
import 'pagination_state.dart';

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
  final int?jumpToPos;
  PaginationEventJumpToPage({required this.page, this.jumpToPos});
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

class PaginationEventChangeState extends IPaginationEvent{
  final PaginationState newState;
  PaginationEventChangeState({required this.newState});
}

