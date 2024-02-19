import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class AutoScrollControllerListener extends StatefulWidget {
  final Widget child;
  final CustomAutoScrollController? customAutoScrollController;
  final int delayMilliSeconds;
  final ScrollDelayType scrollDelayType;
  final void Function(int firstVisibleItemIndex, int lastVisibleItemIndex)? onVisibleItemChanged;
  final void Function(CustomScrollDirection direction)? onScroll;

  const AutoScrollControllerListener({
    super.key,
    required this.child,
    this.delayMilliSeconds = 500,
    this.scrollDelayType = ScrollDelayType.both,
    this.customAutoScrollController,
    this.onVisibleItemChanged,
    this.onScroll
  });

  @override
  State<AutoScrollControllerListener> createState() => _AutoScrollControllerListenerState();
}

class _AutoScrollControllerListenerState extends State<AutoScrollControllerListener> {

  AutoScrollController? get autoScrollController => widget.customAutoScrollController?.controller;

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _addListeners() {
    if(widget.scrollDelayType.isThrottle()){
      autoScrollController?.addListener(_onThrottlePositionChanged);
    }
    if(widget.scrollDelayType.isDebouncer()){
      autoScrollController?.addListener(_onDebouncerPositionChanged);
    }
  }

  void _removeListeners() async {
    if(widget.scrollDelayType.isThrottle()){
      autoScrollController?.removeListener(_onThrottlePositionChanged);
    }
    if(widget.scrollDelayType.isDebouncer()){
      autoScrollController?.removeListener(_onDebouncerPositionChanged);
    }
  }

  void _handlePositionChanged(){
    final controller = widget.customAutoScrollController;
    if(controller == null) return;

    CustomScrollDirection? customScrollDirection;
    if(autoScrollController?.hasClients == true){
      if(autoScrollController?.position.userScrollDirection == ScrollDirection.forward){
        customScrollDirection = CustomScrollDirection.up;
      }else if(autoScrollController?.position.userScrollDirection == ScrollDirection.reverse){
        customScrollDirection = CustomScrollDirection.down;
      }
    }


    controller.calculatePositions(customScrollDirection: customScrollDirection);
    if(customScrollDirection != null) {
      widget.onScroll?.call(customScrollDirection);
    }
    widget.onVisibleItemChanged?.call(controller.firstVisiblePos, controller.lastVisiblePos);
  }

  void _onThrottlePositionChanged(){
    EasyThrottle.throttle(
        "throttle-auto-scrolling",
        Duration(milliseconds: widget.delayMilliSeconds),
        _handlePositionChanged
    );
  }

  void _onDebouncerPositionChanged(){
    EasyDebounce.debounce(
        "debounce-auto-scrolling",
        Duration(milliseconds: widget.delayMilliSeconds),
        _handlePositionChanged
    );
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }
}
