
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadith/core/domain/enums/theme_type_enum.dart';
import 'package:hadith/features/app/color_schemes.g.dart';

class ThemeUtil{

  static bool isLightTheme({
    required ThemeTypeEnum themeEnum,
    required Brightness brightness
  }){
    switch(themeEnum){
      case ThemeTypeEnum.system:
        return brightness == Brightness.light;
      case ThemeTypeEnum.dark:
        return false;
      case ThemeTypeEnum.light:
        return true;
    }
  }

  static ColorScheme getSchema({
    required ThemeTypeEnum themeEnum,
    required Brightness brightness
  }){
    if(isLightTheme(themeEnum: themeEnum, brightness: brightness)){
      return lightColorScheme;
    }
    return darkColorScheme;
  }

  static void setStatusBarColor({
    required ThemeTypeEnum themeEnum,
    required Brightness brightness
  }){
    final schema = getSchema(themeEnum: themeEnum, brightness: brightness);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: schema.primary));
  }

}