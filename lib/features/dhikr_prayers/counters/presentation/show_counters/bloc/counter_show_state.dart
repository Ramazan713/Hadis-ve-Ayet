
import 'package:hadith/core/domain/constants/k_pref.dart';

import '../../../domain/model/counter.dart';


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'counter_show_state.freezed.dart';

@freezed
class CounterShowState with _$CounterShowState{
  const factory CounterShowState({
    required List<Counter> counters,
    required bool showDetailContents
  }) = _CounterShowState;

  static CounterShowState init(){
    return CounterShowState(
      counters: [],
      showDetailContents: KPref.showCounterDetailContents.defaultValue
    );
  }
}