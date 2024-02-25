

import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';

EdgeInsets getCardAdaptivePadding(BuildContext context, {
  WindowSizeClass? windowSizeClass,
}){
  final currentWindowSizeClass = windowSizeClass ?? calculateWindowSize(context);

  switch(currentWindowSizeClass){
    case WindowSizeClass.Compact:
      return const EdgeInsets.only(top: 8, bottom: 4, left: 12, right: 12);
    case WindowSizeClass.Medium:
      return const EdgeInsets.only(top: 12, bottom: 6, left: 16, right: 16);
    case WindowSizeClass.Expanded:
      return const EdgeInsets.only(top: 16, bottom: 12, left: 24, right: 24);
  }
}