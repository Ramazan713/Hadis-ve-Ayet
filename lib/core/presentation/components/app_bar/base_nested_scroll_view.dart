import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/handlers/scrollable_app_bar_handler.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class BaseNestedScrollView extends StatelessWidget {

  final Widget child;
  final CustomScrollController? scrollController;
  final CustomAutoScrollController? contentScrollController;
  final bool floatHeaderSlivers;
  final List<Widget> headerSlivers;
  final Widget sliverAppBar;
  final int delayMilliSeconds;
  final ScrollDelayType scrollDelayType;
  final bool enableScrollableAppBar;

  const BaseNestedScrollView({
    Key? key,
    required this.child,
    required this.sliverAppBar,
    this.floatHeaderSlivers = false,
    this.headerSlivers = const [],
    this.scrollController,
    this.contentScrollController,
    this.delayMilliSeconds = 500,
    this.scrollDelayType = ScrollDelayType.both,
    this.enableScrollableAppBar = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableAppBarHandler(
      contentScrollController: contentScrollController,
      appBarScrollController: scrollController,
      enabled: enableScrollableAppBar,
      delayMilliSeconds: delayMilliSeconds,
      scrollDelayType: scrollDelayType,
      child: NestedScrollView(
        body: child,
        controller: scrollController?.controller,
        floatHeaderSlivers: floatHeaderSlivers,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                sliver: sliverAppBar,
              ),
            ),
            ...headerSlivers
          ];
        },
      ),
    );
  }

}
