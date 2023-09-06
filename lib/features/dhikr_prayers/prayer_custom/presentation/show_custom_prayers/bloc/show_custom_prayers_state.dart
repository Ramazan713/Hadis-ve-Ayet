

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';
part 'show_custom_prayers_state.freezed.dart';

@freezed
class ShowCustomPrayersState with _$ShowCustomPrayersState{
  const factory ShowCustomPrayersState({
    required List<PrayerCustom> items,
    required bool isLoading,
    required String searchQuery,
    required bool isSearchBarVisible,
    required bool showDetailContents,
    String? message
  }) = _ShowCustomPrayersState;

  static ShowCustomPrayersState init(){
    return ShowCustomPrayersState(
      items: [],
      isLoading: false,
      searchQuery: "",
      isSearchBarVisible: false,
      showDetailContents: KPref.showCustomPrayersShowDetailContents.defaultValue
    );
  }
}