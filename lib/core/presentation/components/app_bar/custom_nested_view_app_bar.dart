import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';

class CustomNestedViewAppBar extends StatelessWidget {

  final Widget child;
  final ScrollController? scrollController;
  final bool floatHeaderSlivers;
  final PreferredSizeWidget? appBarBottom;
  final Widget? title;
  final bool pinned;
  final bool snap;
  final bool floating;
  final List<Widget>? actions;
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
    this.floating = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return [
            CustomSliverAppBar(
              title: title,
              actions: actions,
              bottom: appBarBottom,
              floating: floating,
              pinned: pinned,
              snap: snap,
            )
          ];
        },
        child: child
    );
  }
}
