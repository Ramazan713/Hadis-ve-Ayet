import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/presentation/components/app_bar/base_nested_scroll_view.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';

class DefaultNestedScrollableAppBar extends StatelessWidget {

  final Widget child;
  final CustomScrollController? scrollController;
  final CustomAutoScrollController? contentScrollController;
  final bool floatHeaderSlivers;
  final AppBarType? appBarType;
  final PreferredSizeWidget? appBarBottom;
  final Widget? title;
  final bool pinned;
  final bool snap;
  final bool floating;
  final List<Widget>? actions;
  final List<Widget> headerSlivers;
  final double? toolbarHeight;
  final bool? showNavigateBack;
  final int delayMilliSeconds;
  final ScrollDelayType scrollDelayType;
  final Widget? leading;
  final bool enableScrollableAppBar;

  const DefaultNestedScrollableAppBar({
    Key? key,
    required this.child,
    this.floatHeaderSlivers = false,
    this.scrollDelayType = ScrollDelayType.both,
    this.headerSlivers = const [],
    this.delayMilliSeconds = 500,
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    this.enableScrollableAppBar = true,
    this.scrollController,
    this.contentScrollController,
    this.appBarBottom,
    this.title,
    this.actions,
    this.appBarType,
    this.toolbarHeight,
    this.showNavigateBack,
    this.leading
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseNestedScrollView(
      enableScrollableAppBar: enableScrollableAppBar,
      scrollController: scrollController,
      contentScrollController: contentScrollController,
      floatHeaderSlivers: floatHeaderSlivers,
      headerSlivers: headerSlivers,
      delayMilliSeconds: delayMilliSeconds,
      scrollDelayType: scrollDelayType,
      sliverAppBar: CustomSliverAppBar(
        key: const Key("Custom Sliver App Bar"),
        title: title,
        actions: actions,
        bottom: appBarBottom,
        floating: floating,
        pinned: pinned,
        snap: snap,
        appBarType: appBarType,
        toolbarHeight: toolbarHeight,
        leading: leading,
        showNavigateBack: showNavigateBack,
      ),
      child: child,
    );
  }
}
