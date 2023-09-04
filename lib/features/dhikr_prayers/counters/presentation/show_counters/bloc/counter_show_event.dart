

import '../../../domain/model/counter.dart';

abstract class ICounterShowEvent{}

class CounterShowEventInit extends ICounterShowEvent{}

class CounterShowEventLoadData extends ICounterShowEvent{}


class CounterShowEventSetDetailView extends ICounterShowEvent{
  final bool showDetail;
  CounterShowEventSetDetailView({required this.showDetail});
}

class CounterShowEventDelete extends ICounterShowEvent{
  final Counter counter;
  CounterShowEventDelete({required this.counter});
}

