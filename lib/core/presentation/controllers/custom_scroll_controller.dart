
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';

class CustomScrollController with ChangeNotifier{

  late final ScrollController _scrollController;


  CustomScrollController({ScrollController? controller}){
    _scrollController = controller ?? ScrollController();
  }

  CustomScrollDirection _scrollDirection = CustomScrollDirection.up;
  bool _isTopBarVisible = true;


  ScrollController get controller => _scrollController;
  CustomScrollDirection get scrollDirection => _scrollDirection;
  bool get isTopBarVisible => _isTopBarVisible;


  void setScrollDirection(CustomScrollDirection scroll){

    _scrollDirection = scroll;
    _isTopBarVisible = scroll == CustomScrollDirection.up;
    notifyListeners();
  }

  void setScrollDirectionAndAnimateTopBar(CustomScrollDirection scroll){
    if(_scrollController.hasClients == true){
      switch(scroll){
        case CustomScrollDirection.up:
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
          break;
        case CustomScrollDirection.down:
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
          break;
      }
      setScrollDirection(scroll);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}