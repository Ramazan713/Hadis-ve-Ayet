

import 'package:equatable/equatable.dart';

import '../../../domain/model/counter.dart';

class CounterShowState extends Equatable{
  final List<Counter> counters;

  const CounterShowState({required this.counters});

  CounterShowState copyWith({List<Counter>?counters}){
    return CounterShowState(
      counters: counters??this.counters
    );
  }

  static CounterShowState init(){
    return const CounterShowState(
      counters: []
    );
  }

  @override
  List<Object?> get props => [counters];
}
