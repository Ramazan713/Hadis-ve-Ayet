

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/pagination/domain/model/paging_data.dart';
import 'package:hadith/core/pagination/domain/pagination_manager.dart';

import 'pagination_event.dart';
import 'pagination_state.dart';

class PaginationBloc extends Bloc<IPaginationEvent,PaginationState>{

  late final PaginationManager _pagingManager;

  PaginationBloc({required PaginationManager pagingManager}) :super(PaginationState.init()){
    _pagingManager = pagingManager;


    on<PaginationEventInit>(_onSetAndInitPagingManager, transformer: restartable());
    on<PaginationEventListenData>(_onListen, transformer: restartable());
    on<PaginationEventFetchNextPage>(_onFetchNextPage, transformer: restartable());
    on<PaginationEventFetchPreviousPage>(_onFetchPreviousPage, transformer: restartable());
    on<PaginationEventJumpToPage>(_onJumpToPage, transformer: restartable());
    on<PaginationEventJumpToPos>(_onJumpToPos, transformer: restartable());
    on<PaginationEventInValidate>(_onInValidate, transformer: sequential());
  }


  void _onSetAndInitPagingManager(PaginationEventInit event,Emitter<PaginationState>emit)async{
    add(PaginationEventListenData());
    await _pagingManager.init(event.paginationRepo, config: event.config);
  }

  void _onListen(PaginationEventListenData event,Emitter<PaginationState>emit)async{
    await emit.forEach<PagingData>(_pagingManager.streamData, onData: (data){
      return state.copyWith(pagingData: data);
    });
  }


  void _onFetchNextPage(PaginationEventFetchNextPage event,Emitter<PaginationState>emit)async{
    await _pagingManager.fetchNextPage();
  }

  void _onFetchPreviousPage(PaginationEventFetchPreviousPage event,Emitter<PaginationState>emit)async{
    await _pagingManager.fetchPreviousPage(event.firstPos);
  }

  void _onJumpToPage(PaginationEventJumpToPage event,Emitter<PaginationState>emit)async{
    await _pagingManager.jumpToPage(event.page);
  }

  void _onJumpToPos(PaginationEventJumpToPos event,Emitter<PaginationState>emit)async{
    await _pagingManager.jumpToPos(event.pos);
  }

  void _onInValidate(PaginationEventInValidate event,Emitter<PaginationState>emit)async{
    await _pagingManager.invalidateItem(event.item, event.op);
  }


}