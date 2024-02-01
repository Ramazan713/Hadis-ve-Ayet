

import 'package:flutter/material.dart';

class CustomPositionController with ChangeNotifier{

  int _firstVisiblePos = 0;
  int _lastVisiblePos = 0;
  int _middleVisiblePos = 0;
  int _totalItems = 0;

  int get firstVisiblePos => _firstVisiblePos;
  int get lastVisiblePos => _lastVisiblePos;
  int get middleVisiblePos => _middleVisiblePos;
  int get totalItems => _totalItems;

  void setPositions(int firstVisiblePos, int lastVisiblePos, {int? totalItems}){

    _firstVisiblePos = firstVisiblePos;
    _lastVisiblePos = lastVisiblePos;
    _totalItems = totalItems ?? _totalItems;
    _middleVisiblePos = (firstVisiblePos + lastVisiblePos) ~/ 2;

    notifyListeners();
  }

  void setTotalItems(int totalItems){
    _totalItems = totalItems;
    notifyListeners();
  }
}