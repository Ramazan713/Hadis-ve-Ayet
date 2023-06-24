
import 'package:flutter/material.dart';

class CustomSavePointPositionController with ChangeNotifier{

  int _pos = 0;
  int get pos => _pos;

  void setPosition(int pos){
   _pos = pos;
    notifyListeners();
  }
}