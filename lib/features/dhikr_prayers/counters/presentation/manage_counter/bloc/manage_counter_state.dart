


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
part 'manage_counter_state.freezed.dart';

@freezed
class ManageCounterState with _$ManageCounterState{
  const factory ManageCounterState({
    required bool navigateBack,
    required CounterType selectedType,
    required bool isLoading,
    String? message,
    Counter? currentCounter
  }) = _ManageCounterState;

  static ManageCounterState init(){
    return const ManageCounterState(
      navigateBack: false,
      isLoading: false,
      selectedType: CounterType.classic
    );
  }
}