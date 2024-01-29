

import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';

WindowSizeClass calculateWindowSize(BuildContext context){
  final width = MediaQuery.of(context).size.width;
  if(width >= 840){
    return WindowSizeClass.Expanded;
  }
  if(width >= 600){
    return WindowSizeClass.Medium;
  }
  return WindowSizeClass.Compact;
}