import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../domain/enums/paging/paging_status.dart';
import '../../domain/enums/paging/scroll_direction.dart';
import '../../domain/models/paging/i_paging_item.dart';
import 'paging_loading_item.dart';
import 'bloc/pagination_bloc.dart';
import 'bloc/pagination_event.dart';
import 'bloc/pagination_state.dart';

class PagingListView<T extends IPagingItem> extends StatefulWidget {
  final Function(ScrollDirection direction)? onScroll;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final PagingLoadingItem? loadingItem;

  const PagingListView({
    Key? key, required this.itemBuilder, this.onScroll, this.loadingItem,
  }) : super(key: key);

  @override
  State<PagingListView> createState() => _PagingListViewState();
}

class _PagingListViewState extends State<PagingListView> {
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  final ItemScrollController _itemScrollController = ItemScrollController();
  StreamSubscription<Iterable<ItemPosition>>? _posListener;

  final _debouncer = Debouncer<Iterable<ItemPosition>>(
      const Duration(milliseconds: 200),
      initialValue: [],
      checkEquality: true);

  double _previousScrollPosition = -1;
  late ScrollDirection _previousScrollDirection;
  PaginationState? _pagingState;
  PaginationBloc? _paginationBloc;

  @override
  void initState() {
    super.initState();
    _previousScrollDirection = ScrollDirection.up;
    _paginationBloc = context.read<PaginationBloc>();

    _addListeners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaginationBloc, PaginationState>(
      listenWhen: (prevState, nextState) {
        _pagingState = nextState;
        return prevState.jumpToPos != nextState.jumpToPos;
      },
      listener: (context, state) {
        final jumpToPos = state.jumpToPos;
        if (jumpToPos != null && _itemScrollController.isAttached) {
          _itemScrollController.jumpTo(index: jumpToPos,
              alignment: state.jumpToAlignment);
        }
      },
      buildWhen: (prevState, nextState) {
        return prevState.status != nextState.status ||
            prevState.items != nextState.items;
      },
      builder: (context, state) {
        final items = state.items;
        final status = state.status;
        final itemCount = items.length + 2;

        if (status == PagingStatus.loading) {
          return _getLoadingWidget();
        }

        /*
          when _itemScrollController is not attached and bloc event is jumpToPage,
          _itemScrollController.scrollPos not work properly, so initialScrollIndex solve that problem
        */
        var initialScrollIndex =  !_itemScrollController.isAttached &&
            status.isSuccess ? (state.jumpToPos??0):0;
        return ScrollablePositionedList.builder(
          shrinkWrap: false,
          itemCount: itemCount,
          addSemanticIndexes: true,
          addRepaintBoundaries: true,
          initialScrollIndex: initialScrollIndex??0,
          itemPositionsListener: _itemPositionsListener,
          itemScrollController: _itemScrollController,
          itemBuilder: (context, index) {

            final loadingContent = _getLoadingPlaceholderContent(
              status,index,itemCount
            );
            if(loadingContent!=null)return loadingContent;

            final currentIndex = index - 1;
            final item = items[currentIndex];

            return widget.itemBuilder(context, item, currentIndex);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }

  void _addListeners() {
    _itemPositionsListener.itemPositions.addListener(_onPositionChanged);

    _posListener?.cancel();
    _posListener = _debouncer.values.listen((itemsPos) {
      var (min, max) = _getMinMaxPositions(itemsPos);
      _onVisibleItemChanged(min,max);
      _onItemPositionsChanged(min, max);
      _detectScrollPosition(itemsPos);
    });
  }

  void _removeListeners() async {
    _itemPositionsListener.itemPositions.removeListener(_onPositionChanged);
    await _posListener?.cancel();
  }
}


// about extentions of loading widgets
extension _PagingListViewLoadingExt on _PagingListViewState{

  Widget? _getLoadingPlaceholderContent(PagingStatus status,int index, int itemCount){
    if (status.isNextLoading && index == itemCount - 1) {
      return defaultLoading;
    }
    else if (status.isPrevLoading && index == 0) {
      return defaultLoading;
    }
    else if(index == 0){
      return const SizedBox();
    }
    else if (index == itemCount - 1){
      return const SizedBox();
    }
    return null;
  }

  Widget get defaultLoading => const Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  Widget _getLoadingWidget() {
    final loadingItem = widget.loadingItem;

    if (loadingItem == null) {
      return defaultLoading;
    }

    return ListView.builder(
        itemBuilder: (context, index) {
          return loadingItem.loadingWidget;
        },
        itemCount: loadingItem.childCount);
  }
}


// about extentions of positions functions
extension _PagingListViewPositionExt on _PagingListViewState {
  void _onPositionChanged() {
    _debouncer.notify(_itemPositionsListener.itemPositions.value);

  }


  void _onVisibleItemChanged(int firstVisibleItemIndex, int lastVisibleItemIndex){
    if(firstVisibleItemIndex>=0 && lastVisibleItemIndex>=0){
      _paginationBloc?.add(PaginationEventSetVisiblePos(visibleMaxPos: firstVisibleItemIndex,
          visibleMinPos: lastVisibleItemIndex));
    }
  }

  void _onItemPositionsChanged(
      int firstVisibleItemIndex, int lastVisibleItemIndex,
  ) {
    final pagingData = _pagingState;
    if (pagingData == null) return;

    if (firstVisibleItemIndex != -1 && lastVisibleItemIndex != -1) {
      //if first item smaller than preFetch and page is greater than 1
      if (firstVisibleItemIndex <= pagingData.preFetchDistance &&
          pagingData.currentPage > 1) {
        final pos = (lastVisibleItemIndex + firstVisibleItemIndex) ~/ 2;
        _paginationBloc?.add(PaginationEventFetchPreviousPage(firstPos: pos));
      }
      //if lastVisibleItemIndex and prefetch greater than item size
      else if (lastVisibleItemIndex + pagingData.preFetchDistance >=
              pagingData.items.length - 1 &&
          pagingData.currentPage * pagingData.pageSize <
              pagingData.totalItems) {
        _paginationBloc?.add(PaginationEventFetchNextPage());
      }
    }
  }

  void _detectScrollPosition(Iterable<ItemPosition> itemPositions) {
    final currentPosition =
        itemPositions.isNotEmpty ? itemPositions.first.index : -1;
    ScrollDirection? scrollDirection;
    if (currentPosition < _previousScrollPosition || currentPosition == 1) {
      scrollDirection = ScrollDirection.up;
    }
    else if (currentPosition > _previousScrollPosition) {
      scrollDirection = ScrollDirection.down;
    }

    if(scrollDirection!=null && scrollDirection != _previousScrollDirection){
      widget.onScroll?.call(scrollDirection);
      _previousScrollDirection = scrollDirection;
    }

    _previousScrollPosition = currentPosition.toDouble();
  }

  (int, int) _getMinMaxPositions(Iterable<ItemPosition> itemsPos) {
    int min = 0;
    int max = 0;
    if (itemsPos.isNotEmpty) {
      if (itemsPos.last.index > itemsPos.first.index) {
        min = itemsPos.first.index;
        max = itemsPos.last.index;
      } else {
        min = itemsPos.last.index;
        max = itemsPos.first.index;
      }
    }
    // -1 added because LoadingPlaceholderContent causes adding two extra widget
    return (min - 1, max - 1);
  }
}
