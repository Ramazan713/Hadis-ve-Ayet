
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';

class CustomScrollController extends ScrollController{


  void scrollWithAnimateTopBar(ScrollDirection scroll){
    switch(scroll){
      case ScrollDirection.up:
        animateTo(
          position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        break;
      case ScrollDirection.down:
        animateTo(
            position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn);
        break;
    }
  }
}