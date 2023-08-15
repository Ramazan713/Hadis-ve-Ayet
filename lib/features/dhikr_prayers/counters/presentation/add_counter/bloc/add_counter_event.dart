
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

abstract class IAddCounterEvent{}

class AddCounterEventLoadData extends IAddCounterEvent{}

class AddCounterEventClearMessage extends IAddCounterEvent{}

class AddCounterEventClearNavigateBack extends IAddCounterEvent{}


class AddCounterEventAddCounter extends IAddCounterEvent{
  final PrayerDhikr prayer;
  AddCounterEventAddCounter({required this.prayer});
}

