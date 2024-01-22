


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

enum ThemeTypeEnum with IPrefEnum, IMenuItem{
  system(
    enumValue: 1,
    description: "Sistem"
  ),
  dark(
      enumValue: 2,
      description: "Karanlık"
  ),
  light(
      enumValue: 3,
      description: "Aydınlık"
  );

  const ThemeTypeEnum({required this.enumValue, required this.description});

  @override
  final int enumValue;

  final String description;

  @override
  get title => description;

  @override
  get iconInfo => null;


  ThemeMode get mode{
    switch(this){
      case ThemeTypeEnum.system:
        return ThemeMode.system;
      case ThemeTypeEnum.dark:
        return ThemeMode.dark;
      case ThemeTypeEnum.light:
        return ThemeMode.light;
    }
  }

  static ThemeTypeEnum get defaultValue => ThemeTypeEnum.system;

  static ThemeTypeEnum from(int enumValue){

    if(enumValue == ThemeTypeEnum.system.enumValue){
      return ThemeTypeEnum.system;
    }
    else if(enumValue == ThemeTypeEnum.dark.enumValue){
      return ThemeTypeEnum.dark;
    }
    else if(enumValue == ThemeTypeEnum.light.enumValue){
      return ThemeTypeEnum.light;
    }
    return defaultValue;
  }
}
