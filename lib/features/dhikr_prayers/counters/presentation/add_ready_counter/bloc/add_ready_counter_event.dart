
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

abstract class IAddReadyCounterEvent{}

class AddReadyCounterEventLoadData extends IAddReadyCounterEvent{}

class AddReadyCounterEventShowDetails extends IAddReadyCounterEvent{
  final bool showDetails;
  AddReadyCounterEventShowDetails({required this.showDetails});
}

class AddReadyCounterEventSelectItem extends IAddReadyCounterEvent{
  final PrayerDhikr prayer;
  AddReadyCounterEventSelectItem({required this.prayer});
}


class AddReadyCounterEventClearMessage extends IAddReadyCounterEvent{}

class AddReadyCounterEventClearNavigateBack extends IAddReadyCounterEvent{}


class AddReadyCounterEventAddCounter extends IAddReadyCounterEvent{
  final PrayerDhikr prayer;
  AddReadyCounterEventAddCounter({required this.prayer});
}

