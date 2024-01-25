import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';

@Deprecated("Use DefaultNestedScrollableAppBar")
class CustomNestedViewAppBar extends StatelessWidget {

  final Widget child;
  final CustomScrollController? scrollController;
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

  const CustomNestedViewAppBar({
    Key? key,
    required this.child,
    this.scrollController,
    this.floatHeaderSlivers = false,
    this.appBarBottom,
    this.title,
    this.actions,
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    this.appBarType,
    this.toolbarHeight,
    this.showNavigateBack,
    this.headerSlivers = const []
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedView(
        scrollController: scrollController,
        floatHeaderSlivers: floatHeaderSlivers,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                sliver: CustomSliverAppBar(
                  key: const Key("Custom Sliver App Bar"),
                  title: title,
                  actions: actions,
                  bottom: appBarBottom,
                  floating: floating,
                  pinned: pinned,
                  snap: snap,
                  appBarType: appBarType,
                  toolbarHeight: toolbarHeight,
                  showNavigateBack: showNavigateBack,
                ),
              ),
            ),
            ...headerSlivers
          ];
        },
        child: child
    );
  }
}
