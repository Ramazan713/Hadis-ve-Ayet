import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollablePositionedListListener extends StatefulWidget {

  final Widget child;
  final ItemPositionsListener? itemPositionsListener;
  final void Function(CustomScrollDirection direction)? onScroll;
  final int delayMilliSeconds;
  final ScrollDelayType scrollDelayType;
  final void Function(int firstVisibleItemIndex, int lastVisibleItemIndex)? onVisibleItemChanged;
  final int? pageSize;
  final int? itemCount;

  const ScrollablePositionedListListener({
    super.key,
    required this.child,
    this.delayMilliSeconds = 500,
    this.itemPositionsListener,
    this.scrollDelayType = ScrollDelayType.both,
    this.onVisibleItemChanged,
    this.onScroll,
    this.pageSize,
    this.itemCount
  });

  @override
  State<ScrollablePositionedListListener> createState() => _ScrollablePositionedListListenerState();
}

class _ScrollablePositionedListListenerState extends State<ScrollablePositionedListListener> {

  ScrollDelayType get _scrollDelayType => widget.scrollDelayType;
  ItemPositionsListener? get itemPositionsListener => widget.itemPositionsListener;

  double _previousScrollPosition = 0;
  late CustomScrollDirection _previousScrollDirection;
  int? currentHashCore;

  @override
  void initState() {
    super.initState();
    _previousScrollDirection = CustomScrollDirection.up;
    _addListeners();
    currentHashCore = widget.itemPositionsListener.hashCode;
  }

  @override
  Widget build(BuildContext context) {
    if(currentHashCore != widget.itemPositionsListener.hashCode){
      currentHashCore = widget.itemPositionsListener.hashCode;
      _removeListeners();
      _addListeners();
    }
    return widget.child;
  }

  void _addListeners() {
    if(_scrollDelayType.isThrottle()){
      itemPositionsListener?.itemPositions.addListener(_onThrottlePositionChanged);
    }
    if(_scrollDelayType.isDebouncer()){
      itemPositionsListener?.itemPositions.addListener(_onDebouncerPositionChanged);
    }
  }

  void _removeListeners() async {
    if(_scrollDelayType.isThrottle()){
      itemPositionsListener?.itemPositions.removeListener(_onThrottlePositionChanged);
    }
    if(_scrollDelayType.isDebouncer()){
      itemPositionsListener?.itemPositions.removeListener(_onDebouncerPositionChanged);
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
    final itemsPos = itemPositionsListener?.itemPositions.value;
    if(itemsPos == null) return;
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
    else if(widget.itemCount != null && lastVisiblePos >= widget.itemCount! - 1){
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

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }


}
