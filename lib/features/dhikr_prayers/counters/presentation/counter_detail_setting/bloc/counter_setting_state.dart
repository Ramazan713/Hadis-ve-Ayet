


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
part 'counter_setting_state.freezed.dart';

@freezed
class CounterSettingState with _$CounterSettingState{
  const factory CounterSettingState({
    required bool eachDhikrVibration,
    required bool eachEndOfTourVibration
  }) = _CounterSettingState;

  static CounterSettingState init(){
    return CounterSettingState(
      eachDhikrVibration: KPref.eachDhikrVibration.defaultValue,
      eachEndOfTourVibration: KPref.eachEndOfTourVibration.defaultValue
    );
  }

}