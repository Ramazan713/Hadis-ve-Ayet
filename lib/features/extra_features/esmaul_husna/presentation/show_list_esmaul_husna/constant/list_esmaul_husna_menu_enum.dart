

import 'package:flutter/material.dart';

enum ListEsmaulHusnaMenuItem{
  selectFontSize
}


extension ListEsmaulHusnaExt on ListEsmaulHusnaMenuItem{
  String get label{
    switch(this){
      case ListEsmaulHusnaMenuItem.selectFontSize:
        return "Yazı Boyutu";
    }
  }
  IconData get iconData{
    switch(this){
      case ListEsmaulHusnaMenuItem.selectFontSize:
        return Icons.text_format;
    }
  }

}