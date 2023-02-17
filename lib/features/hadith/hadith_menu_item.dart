
import 'package:flutter/material.dart';

enum HadithMenuItem{
  savePoint
}

extension HadithMenuExt on HadithMenuItem{

  String get title{
    switch(this){
      case HadithMenuItem.savePoint:
        return "Kayıt Noktası Oluştur";
    }
  }
  IconData get iconData{
    switch(this){
      case HadithMenuItem.savePoint:
        return Icons.save;
    }
  }

}

