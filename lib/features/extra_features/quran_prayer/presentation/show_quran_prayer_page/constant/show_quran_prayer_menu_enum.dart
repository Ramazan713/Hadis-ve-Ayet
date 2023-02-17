

import 'package:flutter/material.dart';

enum ShowQuranPrayerMenuEnum{
  selectFontSize
}


extension ShowQuranPrayerExt on ShowQuranPrayerMenuEnum{
  String get label{
    switch(this){
      case ShowQuranPrayerMenuEnum.selectFontSize:
        return "Yazı Boyutu";
    }
  }
  IconData get iconData{
    switch(this){
      case ShowQuranPrayerMenuEnum.selectFontSize:
        return Icons.text_format;
    }
  }

}