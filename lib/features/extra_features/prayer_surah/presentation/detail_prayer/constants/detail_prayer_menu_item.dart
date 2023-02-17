

import 'package:flutter/material.dart';

enum DetailPrayerMenuItem{
  fontSize,addCounter
}


extension PrayerMenuExt on DetailPrayerMenuItem{
  String get label{
    switch(this){
      case DetailPrayerMenuItem.fontSize:
        return "Yazı Boyutu";
      case DetailPrayerMenuItem.addCounter:
        return "Zikr olarak kaydet";
    }
  }

  IconData get iconData{
    switch(this){
      case DetailPrayerMenuItem.fontSize:
        return Icons.text_format;
      case DetailPrayerMenuItem.addCounter:
        return Icons.add;
    }
  }

}
