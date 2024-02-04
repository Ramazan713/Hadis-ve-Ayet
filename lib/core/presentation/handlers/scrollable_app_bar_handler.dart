import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/presentation/components/controller_listeners/auto_scroll_controller_listener.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';

class ScrollableAppBarHandler extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final CustomAutoScrollController? contentScrollController;
  final CustomScrollController? appBarScrollController;
  final int delayMilliSeconds;
  final ScrollDelayType scrollDelayType;

  const ScrollableAppBarHandler({
    super.key,
    required this.enabled,
    required this.child,
    required this.contentScrollController,
    required this.appBarScrollController,
    this.delayMilliSeconds = 500,
    this.scrollDelayType = ScrollDelayType.both,
  });

  @override
  Widget build(BuildContext context) {
    if(!enabled){
      return child;
    }
    return AutoScrollControllerListener(
      delayMilliSeconds: delayMilliSeconds,
      scrollDelayType: scrollDelayType,
      customAutoScrollController: contentScrollController,
      onScroll: (scrollDirection){
        appBarScrollController?.setScrollDirectionAndAnimateTopBar(scrollDirection);
      },
      child: child,
    );
  }
}
