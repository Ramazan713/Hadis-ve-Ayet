


import 'package:hadith/core/domain/enums/theme_type_enum.dart';

abstract class IThemeEvent{}

class ThemeEventListenAppPref extends IThemeEvent{}

class ThemeEventSetThemeType extends IThemeEvent{
  final ThemeTypeEnum themeTypeEnum;
  ThemeEventSetThemeType({required this.themeTypeEnum});
}

class ThemeEventClearMessage extends IThemeEvent{}
