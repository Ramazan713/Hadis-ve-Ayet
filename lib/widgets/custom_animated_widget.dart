import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatelessWidget{
  final bool isVisible;
  late final Duration duration;
  final Widget child;
  final void Function()?onEnd;
  CustomAnimatedWidget({Key? key,required this.child,
    Duration? duration,required this.isVisible,this.onEnd}) : super(key: key){
    this.duration=duration??const Duration(milliseconds: 500);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: duration,
      offset: isVisible ? Offset.zero : const Offset(0, 2),
      child: AnimatedOpacity(
        duration: duration,
        opacity: isVisible ? 1 : 0,
        onEnd: onEnd,
        child: child,
      ),
    );
  }

}