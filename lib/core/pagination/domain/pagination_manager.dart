

import 'package:hadith/core/pagination/domain/enums/paging_invalidate_op.dart';
import 'package:hadith/core/pagination/domain/model/i_paging_item.dart';
import 'package:hadith/core/pagination/domain/pagination_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'model/paging_config.dart';
import 'model/paging_data.dart';

abstract class PaginationManager<T extends IPagingItem>{

  final BehaviorSubject<PagingData> _controller = BehaviorSubject();
  Stream<PagingData> get streamData => _controller.stream.asBroadcastStream();

  Future<void> init(PaginationRepo<T> paginationRepo,{required PagingConfig config});

  Future<void> fetchNextPage();

  Future<void> fetchPreviousPage(int currentVisiblePos);

  Future<void> jumpToPage(int pageNumber,{int? jumpToPos});

  Future<void> jumpToPos(int pos);

  Future<void> invalidateItem(T item, PagingInvalidateOp op);

  void setState(PagingData state){
    _controller.add(state);
  }
}