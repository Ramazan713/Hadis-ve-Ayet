import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LazyAlignedGridView extends StatelessWidget {

  final Axis scrollDirection;
  final ScrollController? controller;
  final bool shrinkWrap;
  final double maxCrossAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double? cacheExtent;
  final bool reverse;
  final EdgeInsets? padding;

  const LazyAlignedGridView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.scrollDirection = Axis.vertical,
    this.mainAxisSpacing = 4,
    this.crossAxisSpacing = 4,
    this.maxCrossAxisExtent = 500,
    this.shrinkWrap = false,
    this.reverse = false,
    this.padding,
    this.controller,
    this.cacheExtent,
  });

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.extent(
      scrollDirection: scrollDirection,
      reverse: reverse,
      cacheExtent: cacheExtent,
      controller: controller,
      shrinkWrap: shrinkWrap,
      padding: padding,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      maxCrossAxisExtent: maxCrossAxisExtent,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}