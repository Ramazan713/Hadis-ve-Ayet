import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomScrollablePositionedList extends StatefulWidget {
  final void Function(ScrollDirection direction)? onScroll;
  final Widget Function(BuildContext context, int index) itemBuilder;

  final ItemScrollController? itemScrollController;
  final int itemCount;
  final int initialScrollIndex;
  final bool shrinkWrap;

  final int debouncerDelayMilliSeconds;
  final void Function(int firstVisibleItemIndex, int lastVisibleItemIndex)? onVisibleItemChanged;
  final ItemPositionsListener? itemPositionsListener;

  const CustomScrollablePositionedList({
    Key? key,
    this.onScroll,
    required this.itemBuilder,
    this.itemScrollController,
    required this.itemCount,
    this.debouncerDelayMilliSeconds = 200,
    this.initialScrollIndex = 0,
    this.shrinkWrap = false,
    this.onVisibleItemChanged,
    this.itemPositionsListener
  }) : super(key: key);


  @override
  State<CustomScrollablePositionedList> createState() => _CustomScrollablePositionedListState();
}

class _CustomScrollablePositionedListState extends State<CustomScrollablePositionedList> {

  StreamSubscription<Iterable<ItemPosition>>? _posListener;
  double _previousScrollPosition = 0;
  late ScrollDirection _previousScrollDirection;

  late final Debouncer<Iterable<ItemPosition>> _debouncer;

  late final ItemPositionsListener? itemPositionsListener;

  @override
  void initState() {
    super.initState();
    itemPositionsListener = widget.itemPositionsListener;
    _previousScrollDirection = ScrollDirection.up;

    _debouncer = Debouncer<Iterable<ItemPosition>>(
        Duration(milliseconds: widget.debouncerDelayMilliSeconds),
        initialValue: [],
        checkEquality: true
    );
    _addListeners();

  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        shrinkWrap: false,
        addSemanticIndexes: true,
        addRepaintBoundaries: true,
        itemCount: widget.itemCount,
        itemPositionsListener: itemPositionsListener,
        itemScrollController: widget.itemScrollController,
        itemBuilder: (context, index){
          return widget.itemBuilder(context,index);
        });
  }


  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }

  void _addListeners() {
    itemPositionsListener?.itemPositions.addListener(_onPositionChanged);
    _posListener?.cancel();
    _posListener = _debouncer.values.listen((itemsPos) {

      var (min, max) = _getMinMaxPositions(itemsPos);
      widget.onVisibleItemChanged?.call(min,max);
      _detectScrollPosition(itemsPos);
    });
  }

  void _removeListeners() async {
    itemPositionsListener?.itemPositions.removeListener(_onPositionChanged);
    await _posListener?.cancel();
  }
}


// about extentions of positions functions
extension _CustomScrollablePositionedListStateExt on _CustomScrollablePositionedListState {

  void _onPositionChanged() {
    _debouncer.notify(itemPositionsListener?.itemPositions.value ?? []);
  }

  void _detectScrollPosition(Iterable<ItemPosition> itemPositions) {
    final currentPosition = itemPositions.isNotEmpty ? itemPositions.first.index : -1;
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

    return (min, max);
  }
}