

import 'package:equatable/equatable.dart';

import '../../../domain/model/counter.dart';

class CounterShowStateOld extends Equatable{
  final List<Counter> counters;

  const CounterShowStateOld({required this.counters});

  CounterShowStateOld copyWith({List<Counter>?counters}){
    return CounterShowStateOld(
      counters: counters??this.counters
    );
  }

  static CounterShowStateOld init(){
    return const CounterShowStateOld(
      counters: []
    );
  }

  @override
  List<Object?> get props => [counters];
}
