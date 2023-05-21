import 'dart:math';

import 'package:hadith/core/pagination/domain/model/paging_config.dart';
import 'package:hadith/core/pagination/domain/model/paging_data.dart';
import 'package:hadith/core/pagination/domain/enums/paging_status.dart';
import 'package:hadith/core/pagination/domain/pagination_manager.dart';
import 'package:hadith/core/pagination/domain/pagination_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../domain/model/i_paging_item.dart';
import '../domain/enums/paging_invalidate_op.dart';

class PaginationManagerImpl<T extends IPagingItem> extends PaginationManager<T> {

  PaginationRepo? _paginationRepo;

  var _state = PagingData.init();

  int get _totalPages => _state.totalItems ~/ _state.pageSize;


  @override
  Future<void> init(PaginationRepo<T> paginationRepo,{required PagingConfig config})async{
    _paginationRepo = paginationRepo;
    final int totalItems = await paginationRepo.getTotalItems();
    final currentPage = _calcPageNumber(config.currentPos,config.pageSize);

    _setState(
        PagingData.init().copyWith(
            currentPage: currentPage,
            prevPage: max(currentPage - 1,0),
            pageSize: config.pageSize,
            totalItems: totalItems,
            preFetchDistance: config.preFetchDistance,
        )
    );
    await jumpToPos(config.currentPos);
  }


  @override
  Future<void> fetchNextPage()async{
    if(_state.status.isAnyLoading)return;

    if(_state.currentPage * _state.pageSize < _state.totalItems){
      final nextPage = _state.currentPage + 1;

      _setState(_state.copyWith(currentPage: nextPage,
          status: PagingStatus.nextLoading, jumpToAlignment: 1));

      await _fetchData(
        shouldReplaceItems: false,
        shouldAppendAtEnd: true,
        page: nextPage
      );
    }
  }

  @override
  Future<void> fetchPreviousPage(int currentVisiblePos)async{
    if(_state.status.isAnyLoading)return;
    if(_state.prevPage > 1){
      final prevPage = _state.prevPage - 1;

      _setState(_state.copyWith(prevPage: prevPage,
          status: PagingStatus.prevLoading, jumpToAlignment: 0));

      await _fetchData(shouldReplaceItems: false,shouldAppendAtEnd: false,
          jumpToPos: currentVisiblePos + _state.pageSize - 1,
          page: prevPage
      );
    }
  }

  @override
  Future<void> jumpToPage(int pageNumber,{int? jumpToPos})async{
    if(_state.status.isAnyLoading)return;
    if(_isPageNumberValid(pageNumber)){

      final usePrevPage = pageNumber > 1;
      final updatedPrevPage = pageNumber - 1;
      final updatedNextPage = pageNumber + 1;
      final newJumpToPos = jumpToPos == null ? null :
          usePrevPage ? _state.pageSize + jumpToPos : jumpToPos;

      final newState = _state.copyWith(
          prevPage: usePrevPage ? updatedPrevPage : null,
          currentPage: updatedNextPage,
          status: PagingStatus.loading,
          jumpToAlignment: 0.5,
          jumpToPos: usePrevPage ? _state.pageSize : null
      );
      _setState(newState);


      await _fetchDatas(
          shouldReplaceItems: true, shouldAppendAtEnd: true,
          jumpToPos: newJumpToPos,
          startPage: usePrevPage ? updatedPrevPage : updatedNextPage,
          endPage: updatedNextPage
      );
    }
  }

  @override
  Future<void> jumpToPos(int pos)async{
    if(_state.status.isAnyLoading)return;

    int pageNumber = (pos ~/ _state.pageSize) + 1;
    int jumpToPos = pos % _state.pageSize;

    await jumpToPage(pageNumber, jumpToPos: jumpToPos);
  }


  Future<void> _fetchDatas({
    required int startPage,
    required int endPage,
    bool shouldReplaceItems = true,
    bool shouldAppendAtEnd = true,
    int? jumpToPos
  })async{
    if(_paginationRepo == null)return;
    if(startPage>endPage)return;

    final startIndex = (startPage - 1) * _state.pageSize;
    final maxStartIndex = (endPage - 1) * _state.pageSize;
    final endIndex = min(maxStartIndex + _state.pageSize, _state.totalItems);

    final itemsList = _state.items.toList();

    if(shouldReplaceItems){
      itemsList.clear();
    }
    final items = await _paginationRepo!.getItems(startIndex, endIndex);

    if(shouldAppendAtEnd){
      itemsList.addAll(items);
    }else{
      itemsList.insertAll(0, items);
    }
    _setState(_state.copyWith(items: itemsList,
        status: PagingStatus.success,jumpToPos: jumpToPos, setJumpToPos: jumpToPos!=null));
    _setState(_state.copyWith(setJumpToPos: jumpToPos!=null));
  }



  Future<void> _fetchData({
    required int page,
    bool shouldReplaceItems = true,
    bool shouldAppendAtEnd = true,
    int? jumpToPos
  })async{

    await _fetchDatas(startPage: page, endPage: page,shouldAppendAtEnd: shouldAppendAtEnd,
      shouldReplaceItems: shouldReplaceItems,jumpToPos: jumpToPos);
  }


  void _setState(PagingData state){
    _state = state;
    setState(state);
  }


  @override
  Future<void> invalidateItem(T item,PagingInvalidateOp op)async{
    if(_paginationRepo == null) return;

    final items = _state.items.toList();

    switch(op){
      case PagingInvalidateOp.update:
        final updatedItem = await _paginationRepo!.getUpdatedItem(item);
        if(updatedItem==null)return;

        final index = items.indexWhere((element) => element.pagingId == updatedItem.pagingId);
        if(index != -1){
          items.removeAt(index);
          items.insert(index, updatedItem);
          _setState(_state.copyWith(items: items));
          return;
        }
        break;
      case PagingInvalidateOp.insert:

        break;
      case PagingInvalidateOp.delete:
        items.removeWhere((element) => element.pagingId == item.pagingId);
        _setState(_state.copyWith(items: items));
        break;
      case PagingInvalidateOp.insertOrDelete:

        break;
    }
  }

  bool _isPageNumberValid(pageNumber){
    final totalPages = _totalPages;
    final rangePages = List.generate(totalPages - 1, (index) => index + 1);
    return rangePages.contains(pageNumber);
  }

  int _calcPageNumber(int pos,int pageSize){
    return (pos ~/ pageSize) + 1;
  }
}
