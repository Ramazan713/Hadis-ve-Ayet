import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {

  final Widget firstChild;
  final Widget secondChild;
  final bool showFirstChild;
  late final Duration duration;
  final Curve? switchInCurve;
  final Curve? switchOutCurve;

  CustomAnimatedSwitcher({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    required this.showFirstChild,
    this.switchInCurve,
    this.switchOutCurve,
    Duration? duration,
  }) : super(key: key){
    this.duration = duration ?? const Duration(milliseconds: 300);
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedSwitcher(
      duration: duration,
      key: key,
      switchInCurve: switchInCurve ?? Curves.easeIn,
      switchOutCurve: switchOutCurve ?? Curves.easeOut,
      child: showFirstChild ? firstChild : secondChild,
    );
  }
}
