import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/presentation/builders/custom_scroll_direction_builder.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';

class CustomVisibilityWithContentScrolling extends StatelessWidget {

  final CustomAutoScrollController controller;
  final Widget child;
  final Duration? duration;
  final Curve? curveIn;
  final Curve? curveOut;
  final void Function()? onEnd;

  const CustomVisibilityWithContentScrolling({
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
    return ListenableBuilder(
      listenable: controller,
      builder: (context, c){
        return CustomAnimatedVisibility(
          visible: controller.scrollDirection == CustomScrollDirection.up,
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
