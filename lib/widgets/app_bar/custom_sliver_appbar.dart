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

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions,
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    this.bottom,
    this.appBarType
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        );
    }
  }

}
