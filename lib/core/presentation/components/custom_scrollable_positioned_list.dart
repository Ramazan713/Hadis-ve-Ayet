import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/presentation/controllers/custom_sing_position_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomScrollablePositionedList extends StatefulWidget {
  final void Function(CustomScrollDirection direction)? onScroll;
  final Widget Function(BuildContext context, int index) itemBuilder;

  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  final CustomSinglePositionController? singlePositionController;
  final int itemCount;
  final int initialScrollIndex;
  final bool shrinkWrap;
  final int? pageSize;

  final int delayMilliSeconds;
  final ScrollDelayType scrollDelayType;
  final void Function(int firstVisibleItemIndex, int lastVisibleItemIndex)? onVisibleItemChanged;

  const CustomScrollablePositionedList({
    Key? key,
    this.onScroll,
    required this.itemBuilder,
    this.itemScrollController,
    required this.itemCount,
    this.delayMilliSeconds = 500,
    this.itemPositionsListener,
    this.initialScrollIndex = 0,
    this.shrinkWrap = false,
    this.onVisibleItemChanged,
    this.pageSize,
    this.singlePositionController,
    this.scrollDelayType = ScrollDelayType.both
  }) : super(key: key);


  @override
  State<CustomScrollablePositionedList> createState() => _CustomScrollablePositionedListState();
}

class _CustomScrollablePositionedListState extends State<CustomScrollablePositionedList> {

  double _previousScrollPosition = 0;
  late CustomScrollDirection _previousScrollDirection;

  late final ItemPositionsListener _itemPositionsListener;

  ScrollDelayType get _scrollDelayType => widget.scrollDelayType;

  @override
  void initState() {
    super.initState();

    _itemPositionsListener = widget.itemPositionsListener ?? ItemPositionsListener.create();
    _previousScrollDirection = CustomScrollDirection.up;
    _addListeners();

  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        shrinkWrap: widget.shrinkWrap,
        addSemanticIndexes: true,
        addRepaintBoundaries: true,
        itemCount: widget.itemCount,
        initialScrollIndex: getInitPos(),
        itemPositionsListener: _itemPositionsListener,
        itemScrollController: widget.itemScrollController,
        itemBuilder: (context, index){
          return widget.itemBuilder(context,index);
        });
  }

  int getInitPos(){
    final pos = widget.singlePositionController?.pos;
    if(pos != null && widget.itemScrollController?.isAttached == false){
      widget.singlePositionController?.setPosWithoutNotifier(0);
      return pos;
    }
    return widget.initialScrollIndex;
  }


  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }

  void _addListeners() {

    widget.singlePositionController?.addListener(_listenPosNotifier);

    if(_scrollDelayType.isThrottle()){
      _itemPositionsListener.itemPositions.addListener(_onThrottlePositionChanged);
    }
    if(_scrollDelayType.isDebouncer()){
      _itemPositionsListener.itemPositions.addListener(_onDebouncerPositionChanged);
    }
  }

  void _removeListeners() async {
    widget.singlePositionController?.removeListener(_listenPosNotifier);

    if(_scrollDelayType.isThrottle()){
      _itemPositionsListener.itemPositions.removeListener(_onThrottlePositionChanged);
    }
    if(_scrollDelayType.isDebouncer()){
      _itemPositionsListener.itemPositions.removeListener(_onDebouncerPositionChanged);
    }
  }
}


// about extentions of positions functions
extension _CustomScrollablePositionedListStateExt on _CustomScrollablePositionedListState {

  void _listenPosNotifier(){
    final pos = widget.singlePositionController?.pos;
    if(pos!=null){
      if(widget.itemScrollController?.isAttached == true){
        widget.itemScrollController?.scrollTo(index: pos, duration: const Duration(milliseconds: 300));
      }
    }
  }

  void _onThrottlePositionChanged(){
    EasyThrottle.throttle(
      "throttle-scrolling",
      Duration(milliseconds: widget.delayMilliSeconds),
      _handlePositionChanged
    );
  }

  void _onDebouncerPositionChanged(){
    EasyDebounce.debounce(
        "debounce-scrolling",
        Duration(milliseconds: widget.delayMilliSeconds),
        _handlePositionChanged
    );
  }

  void _handlePositionChanged(){
    final itemsPos = _itemPositionsListener.itemPositions.value;
    var (min, max) = _getMinMaxPositions(itemsPos);

    widget.onVisibleItemChanged?.call(min,max);
    _detectScrollPosition(min,max);
  }

  void _detectScrollPosition(int firstVisiblePos, int lastVisiblePos) {

    CustomScrollDirection? scrollDirection;


    if(firstVisiblePos <= 1){
      scrollDirection = CustomScrollDirection.up;
    }
    else if(widget.pageSize!=null && firstVisiblePos - _previousScrollPosition >= (widget.pageSize!)-1){
      scrollDirection= _previousScrollDirection;
    }
    else if(lastVisiblePos >= widget.itemCount - 1){
      scrollDirection = CustomScrollDirection.down;
    }
    else if (firstVisiblePos < _previousScrollPosition) {
      scrollDirection = CustomScrollDirection.up;
    }

    else if (firstVisiblePos > _previousScrollPosition) {
      scrollDirection = CustomScrollDirection.down;
    }

    if(scrollDirection!=null && scrollDirection != _previousScrollDirection){
      widget.onScroll?.call(scrollDirection);
      _previousScrollDirection = scrollDirection;
    }
    _previousScrollPosition = firstVisiblePos.toDouble();
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
