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
  final bool? showNavigateBack;
  final Widget? leading;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions,
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    this.leading,
    this.bottom,
    this.appBarType,
    this.toolbarHeight,
    this.showNavigateBack
  });


  @override
  Widget build(BuildContext context) {
    return _getAppBar(context);
  }

  SliverAppBar _getAppBar(BuildContext context){
    switch(appBarType ?? AppBarType.defaultBar){
      case AppBarType.defaultBar:
        return SliverAppBar(
          title: title,
          leading: getNavigateBackIcon(context),
          pinned: pinned,
          snap: snap,
          floating: floating,
          key: key,
          bottom: bottom,
          actions: actions,
          automaticallyImplyLeading: false,
          toolbarHeight: toolbarHeight ?? kToolbarHeight,
        );
      case AppBarType.mediumBar:
        return SliverAppBar.medium(
          title: title,
          leading: getNavigateBackIcon(context),
          pinned: pinned,
          snap: snap,
          floating: floating,
          key: key,
          bottom: bottom,
          actions: actions,
          automaticallyImplyLeading: false,
          toolbarHeight: toolbarHeight ?? kToolbarHeight,
        );
      case AppBarType.largeBar:
        return SliverAppBar.large(
          title: title,
          leading: getNavigateBackIcon(context),
          pinned: pinned,
          snap: snap,
          floating: floating,
          key: key,
          bottom: bottom,
          actions: actions,
          automaticallyImplyLeading: false,
          toolbarHeight: toolbarHeight ?? kToolbarHeight,
        );
    }
  }

  Widget? getNavigateBackIcon(BuildContext context){
    if(leading != null) return leading;
    if(showNavigateBack == false) return null;
    if(showNavigateBack == null && !Navigator.canPop(context)) return null;
    return IconButton(
      onPressed: (){
        Navigator.maybePop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

}
