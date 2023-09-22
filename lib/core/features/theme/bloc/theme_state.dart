

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/theme_type_enum.dart';
part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState{
  const factory ThemeState({
    required bool isLoading,
    required ThemeTypeEnum themeType,
    required bool dynamicColorSupported,
    required bool useDynamicColors,
    String? message
  }) = _ThemeState;

  static ThemeState init(){
    return ThemeState(
      isLoading: false,
      themeType: KPref.themeTypeEnum.defaultPrefEnum,
      dynamicColorSupported: false,
      useDynamicColors: false
    );
  }
}