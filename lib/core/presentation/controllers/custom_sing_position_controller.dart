


import 'package:flutter/material.dart';

class CustomSinglePositionController with ChangeNotifier{

  int _pos = 0;

  int get pos => _pos;

  CustomSinglePositionController({int pos = 0}){
    _pos = pos;
  }

  void setPos(int pos){
    _pos = pos;
    notifyListeners();
  }

  void setPosWithoutNotifier(int pos){
    _pos = pos;
  }

}