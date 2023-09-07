

import 'package:flutter/material.dart';

enum ThemeTypesEnumOld{
  system,dark,light
}

extension ThemeEnumExtension on ThemeTypesEnumOld{
  ThemeMode get mode{
    switch(this){
      case ThemeTypesEnumOld.system:
        return ThemeMode.system;
      case ThemeTypesEnumOld.dark:
        return ThemeMode.dark;
      case ThemeTypesEnumOld.light:
        return ThemeMode.light;
    }
  }

  String getDescription(){
    switch(this){
      case ThemeTypesEnumOld.system:
        return "Sistem";
      case ThemeTypesEnumOld.dark:
        return "Karanlık";
      case ThemeTypesEnumOld.light:
        return "Aydınlık";
    }
  }

}