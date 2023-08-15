

import '../../../domain/model/counter.dart';

abstract class ICounterShowEventOld{}

class CounterShowEventInit extends ICounterShowEventOld{}

class CounterShowEventDelete extends ICounterShowEventOld{
  final Counter counter;
  CounterShowEventDelete({required this.counter});
}

