

import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/paging/i_paging_item.dart';
import 'package:hadith/core/features/pagination/paging_modified_item.dart';
import '../../../domain/enums/paging/paging_invalidate_op.dart';
import '../../../domain/enums/paging/paging_status.dart';
import '../../../domain/repo/pagination_repo.dart';
import 'pagination_event.dart';
import 'pagination_state.dart';

class PaginationBloc extends Bloc<IPaginationEvent,PaginationState>{

  PaginationRepo? _paginationRepo;

  PaginationBloc() :super(PaginationState.init()){

    on<PaginationEventInit>(_onInit, transformer: restartable());
    on<PaginationEventFetchNextPage>(_onFetchNextPage, transformer: restartable());
    on<PaginationEventFetchPreviousPage>(_onFetchPreviousPage, transformer: restartable());
    on<PaginationEventJumpToPage>(_onJumpToPage, transformer: restartable());
    on<PaginationEventJumpToPos>(_onJumpToPos, transformer: restartable());
    on<PaginationEventSetVisiblePos>(_onSetVisiblePos, transformer: restartable());
    on<PaginationEventInValidate>(_onInValidate, transformer: sequential());
    on<PaginationEventChangeState>(_onChangeState, transformer: sequential());
  }


  void _onInit(PaginationEventInit event,Emitter<PaginationState>emit)async{

    _paginationRepo = event.paginationRepo;
    final config = event.config;

    final int totalItems = await _paginationRepo!.getTotalItems();
    final currentPage = _calcPageNumber(config.currentPos,config.pageSize);

    emit(
        PaginationState.init().copyWith(
          currentPage: currentPage,
          prevPage: max(currentPage - 1,0),
          pageSize: config.pageSize,
          totalItems: totalItems,
          preFetchDistance: config.preFetchDistance,
          items: [],
        )
    );
    add(PaginationEventJumpToPos(pos: config.currentPos));
  }


  void _onFetchNextPage(PaginationEventFetchNextPage event,Emitter<PaginationState>emit)async{
    if(state.status.isAnyLoading)return;
    if(state.currentPage * state.pageSize >= state.totalItems) return;

    final nextPage = state.currentPage + 1;

    emit(state.copyWith(currentPage: nextPage,
        status: PagingStatus.nextLoading, jumpToAlignment: 1));


    await _fetchData(
        shouldReplaceItems: false,
        shouldAppendAtEnd: true,
        page: nextPage
    );
  }

  void _onFetchPreviousPage(PaginationEventFetchPreviousPage event,Emitter<PaginationState>emit)async{
    if(state.status.isAnyLoading)return;
    if(state.prevPage <= 1) return;

    final prevPage = state.prevPage - 1;

    emit(state.copyWith(prevPage: prevPage,
        status: PagingStatus.prevLoading, jumpToAlignment: 0));

    await _fetchData(shouldReplaceItems: false,shouldAppendAtEnd: false,
        jumpToPos: event.firstPos + state.pageSize - 1,
        page: prevPage
    );
  }

  void _onJumpToPage(PaginationEventJumpToPage event,Emitter<PaginationState>emit)async{
    if(state.status.isAnyLoading) return;
    if(!_isPageNumberValid(event.page)) return;

    final pageNumber = event.page;
    final jumpToPos = event.jumpToPos;

    final usePrevPage = pageNumber > 1;
    final updatedPrevPage = usePrevPage ? pageNumber-1 : 0;
    final currentPage = pageNumber;
    final updatedNextPage = pageNumber + 1;
    final newJumpToPos = jumpToPos == null ? null :
        usePrevPage ? state.pageSize + jumpToPos : jumpToPos;

    emit(state.copyWith(
        prevPage: updatedPrevPage,
        currentPage: updatedNextPage,
        status: PagingStatus.loading,
        jumpToAlignment: 0,
        jumpToPos: usePrevPage ? state.pageSize : null
    ));


    await _fetchDatas(
        shouldReplaceItems: true, shouldAppendAtEnd: true,
        jumpToPos: newJumpToPos,
        startPage: usePrevPage ? updatedPrevPage : currentPage,
        endPage: updatedNextPage
    );
  }

  void _onChangeState(PaginationEventChangeState event,Emitter<PaginationState>emit){
    emit(event.newState);
  }

  void _onJumpToPos(PaginationEventJumpToPos event,Emitter<PaginationState>emit)async{
    if(state.status.isAnyLoading)return;

    int pageNumber = (event.pos ~/ state.pageSize) + 1;
    int jumpToPos = event.pos % state.pageSize;
    add(PaginationEventJumpToPage(page: pageNumber,jumpToPos: jumpToPos));
  }


  void _onSetVisiblePos(PaginationEventSetVisiblePos event,Emitter<PaginationState>emit){

    if(event.visibleMinPos >= 0 && event.visibleMaxPos >= 0){
      emit(state.copyWith(visibleMaxPos: event.visibleMaxPos, visibleMinPos: event.visibleMinPos));
    }
  }


  Future<void> _fetchDatas(
    {
      required int startPage,
      required int endPage,
      bool shouldReplaceItems = true,
      bool shouldAppendAtEnd = true,
      int? jumpToPos,
  })async{
    if(_paginationRepo == null)return;
    if(startPage>endPage)return;

    final startIndex = (startPage - 1) * state.pageSize;
    final maxStartIndex = (endPage - 1) * state.pageSize;
    final endIndex = min(maxStartIndex + state.pageSize, state.totalItems);

    final itemsList = state.items.toList();

    if(shouldReplaceItems){
      itemsList.clear();
    }
    final items = await _paginationRepo!.getItems(startIndex, endIndex);
    if(shouldAppendAtEnd){
      itemsList.addAll(items);
    }else{
      itemsList.insertAll(0, items);
    }

    final newState = state.copyWith(items: itemsList,
        status: PagingStatus.success,jumpToPos: jumpToPos, setJumpToPos: jumpToPos!=null);

    add(PaginationEventChangeState(newState: newState));

    add(PaginationEventChangeState(newState: newState.copyWith(setJumpToPos: jumpToPos!=null)));
  }



  Future<void> _fetchData(
    {
      required int page,
      bool shouldReplaceItems = true,
      bool shouldAppendAtEnd = true,
      int? jumpToPos
  })async{

    await _fetchDatas(startPage: page, endPage: page,shouldAppendAtEnd: shouldAppendAtEnd,
        shouldReplaceItems: shouldReplaceItems,jumpToPos: jumpToPos);
  }

  void _onInValidate(PaginationEventInValidate event,Emitter<PaginationState>emit)async{
    if(_paginationRepo == null) return;

    final items = state.items.toList();

    final updatedItem = await _paginationRepo!.getUpdatedItem(event.item);
    if(updatedItem==null)return null;

    var op = event.op;

    switch(event.op){
      case PagingInvalidateOp.update:
        await _updateItem(items,updatedItem);
        break;
      case PagingInvalidateOp.insert:
        await _insertItem(items, updatedItem, event.pos);
        break;
      case PagingInvalidateOp.delete:
        await _deleteItem(items, updatedItem);
        break;
      case PagingInvalidateOp.unknown:
        final isItemExists = await _paginationRepo?.isItemExists(event.item);
        if(isItemExists == null) return;
        if(isItemExists){//insert or update
          final index = items.indexWhere((element) => element.pagingId == event.item.pagingId);
          if(index!=-1){// if index not -1 item already exists we need to update
            await _updateItem(items, updatedItem);
            op = PagingInvalidateOp.update;
          }else{
            await _insertItem(items, updatedItem, event.pos);
            op = PagingInvalidateOp.insert;
          }
        }else{//delete
          await _deleteItem(items,updatedItem);
          op = PagingInvalidateOp.delete;
        }
        break;
    }

    final lastModifiedItem = PagingModifiedItem(item: updatedItem, op: op);

    emit(state.copyWith(items: items, lastModifiedItem: lastModifiedItem,setLastModifiedItem: true));
  }


  Future<void> _updateItem(List<IPagingItem> items, IPagingItem updatedItem)async{

    final index = items.indexWhere((element) => element.pagingId == updatedItem.pagingId);
    if(index != -1){
      items.removeAt(index);
      items.insert(index, updatedItem);
    }
  }

  Future<void> _insertItem(List<IPagingItem> items,IPagingItem updatedItem, int pos)async{

    items.insert(pos, updatedItem);
    final updatedPosItems = items.sublist(pos + 1).map((e){
      e.rowNumber = e.rowNumber + 1;
      return e;
    }).toList();

    items.replaceRange(pos + 1, items.length, updatedPosItems);
  }

  Future<void> _deleteItem(List<IPagingItem> items,IPagingItem updatedItem)async{

    final index = items.indexWhere((e) => e.pagingId == updatedItem.pagingId);
    if(index == -1) return;

    items.removeAt(index);
    final updatedPosItems = items.toList().sublist(index).map((e){
      e.rowNumber = e.rowNumber - 1;
      return e;
    }).toList();
    items.replaceRange(index, items.length, updatedPosItems);
  }



  bool _isPageNumberValid(pageNumber){
    return pageNumber > 0 && pageNumber <= state.totalPages + 1;
  }

  int _calcPageNumber(int pos,int pageSize){
    return (pos ~/ pageSize) + 1;
  }

}