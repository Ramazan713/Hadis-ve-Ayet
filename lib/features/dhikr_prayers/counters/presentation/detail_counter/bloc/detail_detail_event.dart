

import 'package:hadith/core/domain/enums/verse_ui_4x_enum.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';

abstract class IDetailCounterEvent{}

class DetailCounterEventListenAppPref extends IDetailCounterEvent{}

class DetailCounterEventIncrease extends IDetailCounterEvent{}

class DetailCounterEventReset extends IDetailCounterEvent{}

class CounterDetailEventListenCounter extends IDetailCounterEvent{
  final Counter counter;
  CounterDetailEventListenCounter({required this.counter});
}


class DetailCounterEventLoadDataWithCounterId extends IDetailCounterEvent{
  final int counterId;
  DetailCounterEventLoadDataWithCounterId({required this.counterId});
}

class DetailCounterEventLoadDataWithCounterType extends IDetailCounterEvent{
  final CounterType counterType;
  DetailCounterEventLoadDataWithCounterType({required this.counterType});
}

class DetailCounterEventLoadData extends IDetailCounterEvent{
  final Counter? counter;
  final CounterType counterType;
  DetailCounterEventLoadData({required this.counter,required this.counterType});
}
