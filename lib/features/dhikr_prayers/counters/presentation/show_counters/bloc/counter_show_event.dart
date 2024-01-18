

import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';

import '../../../domain/model/counter.dart';

abstract class ICounterShowEvent{}

class CounterShowEventInit extends ICounterShowEvent{}

class CounterShowEventLoadData extends ICounterShowEvent{}


class CounterShowEventSetDetailView extends ICounterShowEvent{
  final bool showDetail;
  CounterShowEventSetDetailView({required this.showDetail});
}

class CounterShowEventAddToCustomPrayer extends ICounterShowEvent{
  final Counter counter;
  CounterShowEventAddToCustomPrayer({required this.counter});
}

class CounterShowEventAddFromDhikr extends ICounterShowEvent{
  final PrayerDhikr prayer;
  CounterShowEventAddFromDhikr({required this.prayer});
}

class CounterShowEventDelete extends ICounterShowEvent{
  final Counter counter;
  CounterShowEventDelete({required this.counter});
}

class CounterShowEventClearMessage extends ICounterShowEvent{}

