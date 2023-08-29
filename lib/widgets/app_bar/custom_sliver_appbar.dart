import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';

class CustomSliverAppBar extends StatelessWidget {
  final PreferredSizeWidget? bottom;
  final Widget? title;
  final bool pinned;
  final bool snap;
  final bool floating;
  final List<Widget>? actions;
  final AppBarType? appBarType;
  final double? toolbarHeight;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions,
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    this.bottom,
    this.appBarType,
    this.toolbarHeight
  });


  @override
  Widget build(BuildContext context) {
    return _getAppBar(context);
  }

  SliverAppBar _getAppBar(BuildContext context){
    switch(appBarType ?? AppBarType.defaultBar){
      case AppBarType.defaultBar:
        return SliverAppBar(
          pinned: pinned,
          snap: snap,
          floating: floating,
          key: key,
          bottom: bottom,
          actions: actions,
          toolbarHeight: toolbarHeight ?? kToolbarHeight,
        );
      case AppBarType.mediumBar:
        return SliverAppBar.medium(
          pinned: pinned,
          snap: snap,
          floating: floating,
          key: key,
          bottom: bottom,
          title: title,
          actions: actions,
          toolbarHeight: toolbarHeight ?? kToolbarHeight,
        );
      case AppBarType.largeBar:
        return SliverAppBar.large(
          pinned: pinned,
          snap: snap,
          floating: floating,
          key: key,
          bottom: bottom,
          title: title,
          actions: actions,
          toolbarHeight: toolbarHeight ?? kToolbarHeight,
        );
    }
  }

}
