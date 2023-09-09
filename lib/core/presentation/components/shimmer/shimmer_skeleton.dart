

import 'package:flutter/material.dart';

class ShimmerSkeleton extends StatelessWidget {

  final double? height;
  final double? width;
  final int defaultPadding;

  const ShimmerSkeleton({
    Key? key,
    this.height,
    this.width,
    this.defaultPadding = 10
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding:  EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          borderRadius:
          BorderRadius.all(Radius.circular(defaultPadding.toDouble()))),
    );
  }
}