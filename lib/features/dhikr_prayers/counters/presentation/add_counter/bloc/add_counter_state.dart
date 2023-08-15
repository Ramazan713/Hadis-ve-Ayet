



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';
part 'add_counter_state.freezed.dart';

@freezed
class AddCounterState with _$AddCounterState{
  const factory AddCounterState({
    required List<PrayerDhikr> items,
    required bool isLoading,
    required bool navigateBack,
    String? message,
  }) = _AddCounterState;

  static AddCounterState init(){
    return const AddCounterState(
      items: [],
      isLoading: false,
      navigateBack: false,
    );
  }

}
