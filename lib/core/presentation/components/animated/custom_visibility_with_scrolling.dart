import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/presentation/builders/custom_scroll_direction_builder.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';

class CustomVisibilityWithScrolling extends StatelessWidget {

  final ScrollController controller;
  final Widget child;
  final Duration? duration;
  final Curve? curveIn;
  final Curve? curveOut;
  final void Function()? onEnd;

  const CustomVisibilityWithScrolling({
    Key? key,
    required this.controller,
    required this.child,
    this.duration,
    this.curveIn,
    this.curveOut,
    this.onEnd
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollDirectionBuilder(
      controller: controller,
      builder: (context, scrollDirection){
        return CustomAnimatedVisibility(
          visible: scrollDirection == CustomScrollDirection.up,
          curveIn: curveIn,
          curveOut: curveOut,
          duration: duration,
          onEnd: onEnd,
          child: child
        );
      },
    );
  }
}
