

import '../../../domain/model/counter.dart';

abstract class ICounterShowEvent{}

class CounterShowEventInit extends ICounterShowEvent{}

class CounterShowEventDelete extends ICounterShowEvent{
  final Counter counter;
  CounterShowEventDelete({required this.counter});
}

