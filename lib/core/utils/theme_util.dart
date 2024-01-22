
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadith/core/features/theme/domain/enums/theme_type_enum.dart';
import 'package:hadith/core/features/theme/domain/models/theme_scheme.dart';
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




  static ThemeScheme getSchemes({
    required ThemeTypeEnum themeEnum,
    required Brightness brightness,
    required bool dynamicColorSupported,
    required bool useDynamicColor,
    ColorScheme? lightDynamic,
    ColorScheme? darkDynamic,
  }){

    final lightScheme = _getLightScheme(
      dynamicColorSupported: dynamicColorSupported,
      useDynamicColor: useDynamicColor,
      lightDynamic: lightDynamic
    );

    final darkScheme = _getDarkScheme(
        dynamicColorSupported: dynamicColorSupported,
        useDynamicColor: useDynamicColor,
        darkDynamic: darkDynamic
    );

    final currentScheme = isLightTheme(themeEnum: themeEnum, brightness: brightness) ? lightScheme : darkScheme;

    return ThemeScheme(
      currentScheme: currentScheme,
      darkScheme: darkScheme,
      lightScheme: lightScheme
    );
  }

  static void setStatusBarColor({
    required ColorScheme schema
  }){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: schema.primary));
  }


  static ColorScheme _getLightScheme({
    required bool dynamicColorSupported,
    required bool useDynamicColor,
    ColorScheme? lightDynamic,
  }){
    if(!dynamicColorSupported || !useDynamicColor) return lightColorScheme;
    return lightDynamic ?? lightColorScheme;
  }

  static ColorScheme _getDarkScheme({
    required bool dynamicColorSupported,
    required bool useDynamicColor,
    ColorScheme? darkDynamic,
  }){
    if(!dynamicColorSupported || !useDynamicColor) return darkColorScheme;
    return darkDynamic ?? darkColorScheme;
  }
}