import 'dart:async';
import 'dart:math';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/pagination/domain/enums/paging_status.dart';
import 'package:hadith/core/pagination/domain/model/i_paging_item.dart';
import 'package:hadith/core/pagination/domain/model/paging_data.dart';
import 'package:hadith/core/pagination/domain/enums/scroll_direction.dart';
import 'package:hadith/core/pagination/domain/model/paging_loading_item.dart';
import 'package:hadith/core/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/features/hadiths/domain/hadith_list_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/pagination_bloc.dart';
import 'bloc/pagination_state.dart';

class PagingListView<T extends IPagingItem> extends StatefulWidget {
  final Function(ScrollDirection direction)? onScroll;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final PagingLoadingItem? loadingItem;

  const PagingListView(
      {Key? key, required this.itemBuilder, this.onScroll, this.loadingItem})
      : super(key: key);

  @override
  State<PagingListView> createState() => _PagingListViewState();
}

class _PagingListViewState extends State<PagingListView> {
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController _itemScrollController = ItemScrollController();
  StreamSubscription<Iterable<ItemPosition>>? _posListener;
  final _debouncer = Debouncer<Iterable<ItemPosition>>(
      const Duration(milliseconds: 100),
      initialValue: [],
      checkEquality: false);

  double _previousScrollPosition = 0;
  late ScrollDirection _scrollDirection;
  PagingData? _pagingData;
  PaginationBloc? _paginationBloc;

  @override
  void initState() {
    super.initState();
    _scrollDirection = ScrollDirection.down;
    _paginationBloc = context.read<PaginationBloc>();

    _addListeners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaginationBloc, PaginationState>(
      listenWhen: (prevState, nextState) {
        _pagingData = nextState.pagingData;
        print("statusx: ${_pagingData?.status}");
        return prevState.pagingData.jumpToPos != nextState.pagingData.jumpToPos;
      },
      listener: (context, state) {
        final jumpToPos = state.pagingData.jumpToPos;
        print("jumpToPosListen: $jumpToPos");
        if (jumpToPos != null && _itemScrollController.isAttached) {
          _itemScrollController.jumpTo(index: jumpToPos,
              alignment: state.pagingData.jumpToAlignment);
        }
      },
      buildWhen: (prevState, nextState) {
        final prevData = prevState.pagingData;
        final nextData = nextState.pagingData;
        return prevData.status != nextData.status ||
            prevData.items != nextData.items;
      },
      builder: (context, state) {
        final items = state.pagingData.items;
        final status = state.pagingData.status;

        if (status == PagingStatus.loading) {
          return _getLoadingWidget();
        }

        var itemCount = items.length;
        var isPrevOrNextLoading = status.isNextLoading || status.isPrevLoading;
        if (isPrevOrNextLoading) {
          itemCount++;
        }

        /*
          when _itemScrollController is not attached and bloc event is jumpToPage,
          _itemScrollController.scrollPos not work properly, so initialScrollIndex solve that problem
        */
        var initialScrollIndex =  !_itemScrollController.isAttached &&
            status.isSuccess ? (state.pagingData.jumpToPos??0):0;
        print("initialScrollIndex: $initialScrollIndex");
        return ScrollablePositionedList.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          initialScrollIndex: initialScrollIndex,
          itemPositionsListener: _itemPositionsListener,
          itemScrollController: _itemScrollController,
          itemBuilder: (context, index) {
            if (status.isNextLoading && index == itemCount - 1) {
              return defaultLoading;
            } else if (status.isPrevLoading && index == 0) {
              return defaultLoading;
            }

            final currentIndex =
                max(isPrevOrNextLoading ? index - 1 : index, 0);
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

  void _addListeners() {
    _itemPositionsListener.itemPositions.addListener(_onPositionChanged);

    _posListener?.cancel();
    _posListener = _debouncer.values.listen((itemsPos) {
      var (min, max) = _getMinMaxPositions(itemsPos);
      _onItemPositionsChanged(min, max);
      _detectScrollPosition(itemsPos);
    });
  }

  void _removeListeners() async {
    _itemPositionsListener.itemPositions.removeListener(_onPositionChanged);
    await _posListener?.cancel();
  }
}

// about extentions of positions functions
extension _PagingListViewExt on _PagingListViewState {
  void _onPositionChanged() {
    _debouncer.notify(_itemPositionsListener.itemPositions.value);
  }

  void _onItemPositionsChanged(
      int firstVisibleItemIndex, int lastVisibleItemIndex) {
    final pagingData = _pagingData;
    if (pagingData == null) return;

    // print("firstVisibleItemIndex: $firstVisibleItemIndex : $lastVisibleItemIndex: ${pagingData.currentPage}");
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

    if (currentPosition > _previousScrollPosition) {
      _scrollDirection = ScrollDirection.down;
    } else if (currentPosition < _previousScrollPosition) {
      _scrollDirection = ScrollDirection.up;
    }
    widget.onScroll?.call(_scrollDirection);
    _previousScrollPosition = currentPosition.toDouble();
  }

  (int, int) _getMinMaxPositions(Iterable<ItemPosition> itemsPos) {
    int min = -1;
    int max = -1;
    if (itemsPos.isNotEmpty) {
      if (itemsPos.last.index > itemsPos.first.index) {
        min = itemsPos.first.index;
        max = itemsPos.last.index;
      } else {
        min = itemsPos.last.index;
        max = itemsPos.first.index;
      }
    }
    return (min, max);
  }
}
