

import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';

EdgeInsets getCardAdaptiveMargin(BuildContext context, {
  WindowSizeClass? windowSizeClass
}){
  final currentWindowSizeClass = windowSizeClass ?? calculateWindowSize(context);

  switch(currentWindowSizeClass){
    case WindowSizeClass.Compact:
      return const EdgeInsets.symmetric(vertical: 4);
    case WindowSizeClass.Medium:
      return const EdgeInsets.symmetric(vertical: 6);
    case WindowSizeClass.Expanded:
      return const EdgeInsets.symmetric(vertical: 6);
  }
}