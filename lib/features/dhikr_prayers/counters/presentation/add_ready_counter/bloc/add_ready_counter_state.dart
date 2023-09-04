



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'add_ready_counter_state.freezed.dart';

@freezed
class AddReadyCounterState with _$AddReadyCounterState{
  const factory AddReadyCounterState({
    required List<PrayerDhikr> items,
    required bool isLoading,
    required bool navigateBack,
    required bool showDetails,
    PrayerDhikr? selectedItem,
    String? message,
  }) = _AddReadyCounterState;

  static AddReadyCounterState init(){
    return AddReadyCounterState(
      items: [],
      isLoading: false,
      navigateBack: false,
      showDetails: KPref.addCounterShowDetails.defaultValue
    );
  }

}


