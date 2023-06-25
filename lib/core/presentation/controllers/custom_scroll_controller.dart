
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';

class CustomScrollController with ChangeNotifier{

  ScrollDirection _scrollDirection = ScrollDirection.up;
  bool _isTopBarVisible = true;

  final ScrollController _scrollController = ScrollController();

  ScrollController get controller => _scrollController;
  ScrollDirection get scrollDirection => _scrollDirection;
  bool get isTopBarVisible => _isTopBarVisible;


  void setScrollDirection(ScrollDirection scroll){

    _scrollDirection = scroll;
    _isTopBarVisible = scroll == ScrollDirection.up;
    notifyListeners();
  }

  void setScrollDirectionAndAnimateTopBar(ScrollDirection scroll){

    switch(scroll){
      case ScrollDirection.up:
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        break;
      case ScrollDirection.down:
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn);
        break;
    }
    setScrollDirection(scroll);
  }
}