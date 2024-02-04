import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/presentation/components/controller_listeners/scrollable_positioned_list_listener.dart';
import 'package:hadith/core/presentation/components/controller_listeners/single_position_controller_listener.dart';
import 'package:hadith/core/presentation/controllers/custom_sing_position_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class CustomScrollablePositionedList extends StatelessWidget {


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
  Widget build(BuildContext context) {
    return ScrollablePositionedListListener(
      scrollDelayType: scrollDelayType,
      delayMilliSeconds: delayMilliSeconds,
      onVisibleItemChanged: onVisibleItemChanged,
      itemCount: itemCount,
      itemPositionsListener: itemPositionsListener,
      onScroll: onScroll,
      pageSize: pageSize,
      child: SinglePositionControllerListener(
        singlePositionController: singlePositionController,
        onPosChanged: (pos){
          if(itemScrollController?.isAttached == true){
            itemScrollController?.scrollTo(index: pos, duration: const Duration(milliseconds: 300));
          }
        },
        child: ScrollablePositionedList.builder(
          shrinkWrap: shrinkWrap,
          addSemanticIndexes: true,
          addRepaintBoundaries: true,
          itemCount: itemCount,
          initialScrollIndex: getInitPos(),
          itemPositionsListener: itemPositionsListener,
          itemScrollController: itemScrollController,
          itemBuilder: (context, index){
            return itemBuilder(context,index);
          }),
      ),
    );
  }

  int getInitPos(){
    final pos = singlePositionController?.pos;
    if(pos != null && itemScrollController?.isAttached == false){
      singlePositionController?.setPosWithoutNotifier(0);
      return pos;
    }
    return initialScrollIndex;
  }
}

