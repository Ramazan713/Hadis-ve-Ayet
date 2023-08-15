

import 'package:equatable/equatable.dart';

import '../../../domain/model/counter.dart';


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'counter_show_state.freezed.dart';

@freezed
class CounterShowState with _$CounterShowState{
  const factory CounterShowState({
    required List<Counter> counters
  }) = _CounterShowState;

  static CounterShowState init(){
    return const CounterShowState(
        counters: []
    );
  }
}