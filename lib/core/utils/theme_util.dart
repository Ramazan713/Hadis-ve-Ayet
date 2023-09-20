
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
    required Brightness brightness,
    required bool dynamicColorSupported,
    required bool useDynamicColor,
    ColorScheme? lightDynamic,
    ColorScheme? darkDynamic,
  }){
    if(isLightTheme(themeEnum: themeEnum, brightness: brightness)){
      if(!dynamicColorSupported || !useDynamicColor) return lightColorScheme;
      return lightDynamic ?? lightColorScheme;
    }
    if(!dynamicColorSupported || !useDynamicColor) return darkColorScheme;
    return darkDynamic ?? darkColorScheme;
  }

  static void setStatusBarColor({
    required ColorScheme schema
  }){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: schema.primary));
  }

}