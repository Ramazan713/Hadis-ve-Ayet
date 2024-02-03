import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';

class AdaptivePadding extends StatelessWidget {
  final Widget child;
  final bool useAdaptivePadding;
  final WindowSizeClass? windowSizeClass;

  const AdaptivePadding({
    super.key,
    required this.child,
    this.useAdaptivePadding = true,
    this.windowSizeClass
  });

  @override
  Widget build(BuildContext context) {
    if(!useAdaptivePadding){
      return child;
    }
    final currentWindowSizeClass = windowSizeClass ?? calculateWindowSize(context);

    return Padding(
      padding: getPaddings(currentWindowSizeClass),
      child: child,
    );
  }

  EdgeInsets getPaddings(WindowSizeClass windowSizeClass){
    final EdgeInsets padding;
    switch(windowSizeClass){
      case WindowSizeClass.Compact:
        padding = const EdgeInsets.symmetric(horizontal: 12);
        break;
      case WindowSizeClass.Medium:
        padding = const EdgeInsets.symmetric(horizontal: 24);
        break;
      case WindowSizeClass.Expanded:
        padding = const EdgeInsets.symmetric(horizontal: 24);
        break;
    }
    return padding;
  }

}
