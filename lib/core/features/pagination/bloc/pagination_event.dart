import 'package:hadith/core/domain/models/paging/i_paging_item.dart';

import '../../../domain/enums/paging/paging_invalidate_op.dart';
import '../../../domain/models/paging/paging_config.dart';
import '../../../domain/repo/pagination_repo.dart';
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

class PaginationEventSetVisiblePos extends IPaginationEvent{
  final int visibleMinPos;
  final int visibleMaxPos;
  PaginationEventSetVisiblePos({required this.visibleMaxPos, required this.visibleMinPos});
}

class PaginationEventInValidate extends IPaginationEvent{
  final IPagingItem item;
  final PagingInvalidateOp op;
  final int pos;
  PaginationEventInValidate({required this.item,required this.op, this.pos = 0});
}

class PaginationEventChangeState extends IPaginationEvent{
  final PaginationState newState;
  PaginationEventChangeState({required this.newState});
}

