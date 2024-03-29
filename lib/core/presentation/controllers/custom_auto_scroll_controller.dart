
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CustomAutoScrollController with ChangeNotifier{

  late final AutoScrollController _scrollController;

  CustomAutoScrollController({
    AutoScrollController? autoScrollController,
    double? suggestedRowHeight
  }){
    _scrollController = autoScrollController ?? AutoScrollController(
      suggestedRowHeight: suggestedRowHeight,
    );
  }

  AutoScrollController get controller => _scrollController;

  int _firstVisiblePos = 0;
  int _lastVisiblePos = 0;
  int _middleVisiblePos = 0;
  int _totalItems = 0;
  CustomScrollDirection _scrollDirection = CustomScrollDirection.up;

  int get firstVisiblePos => _firstVisiblePos;
  int get lastVisiblePos => _lastVisiblePos;
  int get middleVisiblePos => _middleVisiblePos;
  int get totalItems => _totalItems;
  CustomScrollDirection get scrollDirection => _scrollDirection;

  void calculatePositions({int? totalItems, CustomScrollDirection? customScrollDirection}){
    final values = _scrollController.tagMap.values;
    _firstVisiblePos = values.firstOrNull?.widget.index ?? _firstVisiblePos;
    _lastVisiblePos = values.lastOrNull?.widget.index ?? _firstVisiblePos;
    _totalItems = totalItems ?? _totalItems;
    _middleVisiblePos = (firstVisiblePos + lastVisiblePos) ~/ 2;
    _scrollDirection = customScrollDirection ?? _scrollDirection;

    notifyListeners();
  }

  void setScrollDirection(CustomScrollDirection customScrollDirection){
    _scrollDirection = customScrollDirection;
    notifyListeners();
  }

  void setTotalItems({required int totalItems}){
    _totalItems = totalItems;
    notifyListeners();
  }

  Future scrollToIndex(int index, {
    Duration? duration,
    AutoScrollPosition? preferPosition
  })async{
    Future.delayed(const Duration(milliseconds: 200),() {
      _scrollController.scrollToIndex(index,
          duration: duration ?? scrollAnimationDuration,
          preferPosition: preferPosition
      );
    },);

  }
}