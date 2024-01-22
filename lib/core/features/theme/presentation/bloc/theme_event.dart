
import 'package:hadith/core/features/theme/domain/enums/theme_type_enum.dart';

abstract class IThemeEvent{}

class ThemeEventInit extends IThemeEvent{}

class ThemeEventListenAppPref extends IThemeEvent{}

class ThemeEventSetUseDynamicColor extends IThemeEvent{
  final bool useDynamicColors;
  ThemeEventSetUseDynamicColor({required this.useDynamicColors});
}

class ThemeEventSetThemeType extends IThemeEvent{
  final ThemeTypeEnum themeTypeEnum;
  ThemeEventSetThemeType({required this.themeTypeEnum});
}

class ThemeEventClearMessage extends IThemeEvent{}
