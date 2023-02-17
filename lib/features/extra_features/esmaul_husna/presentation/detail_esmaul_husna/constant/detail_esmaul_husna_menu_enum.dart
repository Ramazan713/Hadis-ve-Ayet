

import 'package:flutter/material.dart';

enum DetailEsmaulHusnaMenuEnum{
  selectFontSize
}


extension DetailEsmaulHusnaExt on DetailEsmaulHusnaMenuEnum{
  String get label{
    switch(this){
      case DetailEsmaulHusnaMenuEnum.selectFontSize:
        return "Yazı Boyutu";
    }
  }
  IconData get iconData{
    switch(this){
      case DetailEsmaulHusnaMenuEnum.selectFontSize:
        return Icons.text_format;
    }
  }

}