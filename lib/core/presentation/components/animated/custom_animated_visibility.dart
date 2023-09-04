import 'package:flutter/material.dart';

import 'custom_animated_switcher.dart';

class CustomAnimatedVisibility extends StatelessWidget {

  final bool visible;
  final Widget child;
  final Duration? duration;
  final Curve? curveIn;
  final Curve? curveOut;
  final void Function()? onEnd;

  const CustomAnimatedVisibility({
    Key? key,
    required this.visible,
    required this.child,
    this.duration,
    this.curveIn,
    this.curveOut,
    this.onEnd
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedSwitcher(
      duration: duration ?? const Duration(milliseconds: 300),
      showFirstChild: visible,
      switchInCurve: curveIn,
      switchOutCurve: curveOut,
      firstChild: child,
      secondChild: const SizedBox.shrink(),
    );
  }
}
