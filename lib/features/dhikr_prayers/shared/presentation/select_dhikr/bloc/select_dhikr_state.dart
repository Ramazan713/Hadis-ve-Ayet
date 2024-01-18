



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'select_dhikr_state.freezed.dart';

@freezed
class SelectDhikrState with _$SelectDhikrState{
  const factory SelectDhikrState({
    required List<PrayerDhikr> items,
    required bool isLoading,
    required bool showDetails,
    PrayerDhikr? selectedItem,
  }) = _SelectDhikrState;

  static SelectDhikrState init(){
    return SelectDhikrState(
      items: [],
      isLoading: false,
      showDetails: KPref.selectDhikrShowDetails.defaultValue
    );
  }

}


