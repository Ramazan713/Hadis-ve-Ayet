import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class BaseNestedScrollView extends StatefulWidget {

  final Widget child;
  final CustomScrollController? scrollController;
  final CustomAutoScrollController? contentScrollController;
  final bool floatHeaderSlivers;
  final List<Widget> headerSlivers;
  final Widget sliverAppBar;
  final int delayMilliSeconds;
  final ScrollDelayType scrollDelayType;

  const BaseNestedScrollView({
    Key? key,
    required this.child,
    required this.sliverAppBar,
    this.floatHeaderSlivers = false,
    this.headerSlivers = const [],
    this.scrollController,
    this.contentScrollController,
    this.delayMilliSeconds = 500,
    this.scrollDelayType = ScrollDelayType.both
  }) : super(key: key);

  @override
  State<BaseNestedScrollView> createState() => _BaseNestedScrollViewState();
}

class _BaseNestedScrollViewState extends State<BaseNestedScrollView> {

  AutoScrollController? get autoScrollController => widget.contentScrollController?.controller;

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        body: widget.child,
        controller: widget.scrollController?.controller,
        floatHeaderSlivers: widget.floatHeaderSlivers,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                sliver: widget.sliverAppBar,
              ),
            ),
            ...widget.headerSlivers
          ];
        },
    );
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
    final controller = widget.scrollController;
    if(autoScrollController?.position.userScrollDirection == ScrollDirection.forward){
      controller?.setScrollDirectionAndAnimateTopBar(CustomScrollDirection.up);
    }else if(autoScrollController?.position.userScrollDirection == ScrollDirection.reverse){
      controller?.setScrollDirectionAndAnimateTopBar(CustomScrollDirection.down);
    }
    widget.contentScrollController?.calculatePositions();
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

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }
}
