

import 'dart:collection';
import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/domain/enums/paging_invalidate_op.dart';
import 'package:hadith/core/features/pagination/domain/enums/paging_status.dart';
import 'package:hadith/core/features/pagination/domain/models/i_paging_item.dart';
import 'package:hadith/core/features/pagination/domain/models/paging_modified_item.dart';
import 'package:hadith/core/features/pagination/domain/repo/pagination_repo.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_state.dart';



class PaginationBloc extends Bloc<IPaginationEvent,PaginationState>{

  PaginationRepo? _paginationRepo;

  PaginationBloc() :super(PaginationState.init()){

    on<PaginationEventInit>(_onInit, transformer: restartable());
    on<PaginationEventFetchNextPage>(_onFetchNextPage, transformer: restartable());
    on<PaginationEventFetchPreviousPage>(_onFetchPreviousPage, transformer: restartable());
    on<PaginationEventJumpToPage>(_onJumpToPage, transformer: restartable());
    on<PaginationEventChangePage>(_onChangePage, transformer: restartable());
    on<PaginationEventJumpToPos>(_onJumpToPos, transformer: restartable());
    on<PaginationEventSetVisiblePos>(_onSetVisiblePos, transformer: restartable());
    on<PaginationEventInValidate>(_onInValidate, transformer: sequential());
    on<PaginationEventChangeState>(_onChangeState, transformer: sequential());
  }

  void _onInit(PaginationEventInit event,Emitter<PaginationState>emit)async{

    _paginationRepo = event.paginationRepo;
    final config = event.config;

    emit(PaginationState.init().copyWith(status: PagingStatus.loading));

    final int totalItems = await _paginationRepo!.getTotalItems();
    final currentPage = config.currentPage ?? _calcPageNumber(config.currentPos,config.pageSize);
    emit(PaginationState.init().copyWith(
        currentPage: currentPage,
        prevPage: max(currentPage - 1,0),
        pageSize: config.pageSize,
        preFetchDistance: config.preFetchDistance,
        totalItems: totalItems,
    ));

    if(config.currentPage != null){
      add(PaginationEventChangePage(page: currentPage));
    }else{
      add(PaginationEventJumpToPos(pos: config.currentPos));
    }
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

  void _onJumpToPos(PaginationEventJumpToPos event,Emitter<PaginationState>emit)async{
    if(state.status.isAnyLoading)return;

    int pageNumber = (event.pos ~/ state.pageSize) + 1;
    int jumpToPos = event.pos % state.pageSize;
    add(PaginationEventJumpToPage(page: pageNumber,jumpToPos: jumpToPos));
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

  void _onChangePage(PaginationEventChangePage event,Emitter<PaginationState>emit)async{
    EasyDebounce.debounce("pagination_by_page", const Duration(milliseconds: 300), () async{
      if(event.page > state.totalStaticItems) return;
      final pageNumber = max(event.page, 1);

      int currentPage = 1;
      bool clearAll = false;

      // next page
      if(pageNumber >= state.currentPage && pageNumber <= state.currentPage + state.preFetchDistance){
        currentPage = pageNumber;
      } else if(pageNumber < state.currentPage && pageNumber >= state.currentPage - state.preFetchDistance){ // prev page
        currentPage = pageNumber - 1;
      }else{
        clearAll = true;
        currentPage = pageNumber;
      }

      int endPage = max(currentPage + state.preFetchDistance, 1);
      int prevPage = max(currentPage - 1 - state.preFetchDistance, 1);
      await _fetchDatasByPage(
        startPage: prevPage,
        endPage: endPage,
        currentPage: currentPage,
        clearAll: clearAll
      );
    });
  }

  void _onChangeState(PaginationEventChangeState event,Emitter<PaginationState>emit){
    emit(event.newState);
  }

  void _onSetVisiblePos(PaginationEventSetVisiblePos event,Emitter<PaginationState>emit){

    if(event.visibleMinPos >= 0 && event.visibleMaxPos >= 0){
      emit(state.copyWith(visibleMaxPos: event.visibleMaxPos, visibleMinPos: event.visibleMinPos));
    }
  }

  Future<void> _fetchDatasByPage({
    required int startPage,
    required int endPage,
    required int currentPage,
    bool clearAll = false
  })async{
    if(_paginationRepo == null)return;
    if(startPage>endPage)return;
    final itemsByPage = state.itemsByPage;

    if(clearAll){
      itemsByPage.clear();
    }

    final initLoadingStatus = clearAll ? PagingStatus.loading : state.status;
    add(PaginationEventChangeState(newState: state.copyWith(
      status: initLoadingStatus,
      prevPage: startPage,
      currentPage: currentPage,
    )));

    for(int page = startPage ; page <= endPage ; page++){
      if(!itemsByPage.keys.contains(page)){
        final items = await _paginationRepo!.getItems(0,0, page, page);
        itemsByPage.putIfAbsent(page, () => items);
      }
    }

    add(PaginationEventChangeState(newState: state.copyWith(
        status: PagingStatus.success,
        itemsByPage: itemsByPage
    )));
  }

  Future<void> _fetchDatas({
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
    final itemsByPage = state.itemsByPage;

    if(shouldReplaceItems){
      itemsList.clear();
      itemsByPage.clear();
    }
    final items = await _paginationRepo!.getItems(startIndex, endIndex, startPage, endPage);
    if(shouldAppendAtEnd){
      itemsList.addAll(items);
    }else{
      itemsList.insertAll(0, items);
    }
    itemsByPage.putIfAbsent(startPage, () => items);

    final newState = state.copyWith(
      items: itemsList,
      itemsByPage: itemsByPage,
      status: PagingStatus.success,
      jumpToPos: jumpToPos,
    );

    add(PaginationEventChangeState(newState: newState));

    add(PaginationEventChangeState(newState: newState.copyWith(jumpToPos: null)));
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

    final stateItems = state.items.toList();

    final List<IPagingItem> items = stateItems.isEmpty ? state.itemsByPage.values.flattened.toList() : stateItems;

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
    final updatedItemsByPage = HashMap<int,List<IPagingItem>>.from(items.groupListsBy((e) => _paginationRepo?.groupBy(e)));

    emit(state.copyWith(
        items: items,
        itemsByPage: updatedItemsByPage,
        lastModifiedItem: lastModifiedItem,
    ));
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
    return pageNumber > 0 && pageNumber <= state.totalDynamicPages + 1;
  }

  int _calcPageNumber(int pos,int pageSize){
    return (pos ~/ pageSize) + 1;
  }

}