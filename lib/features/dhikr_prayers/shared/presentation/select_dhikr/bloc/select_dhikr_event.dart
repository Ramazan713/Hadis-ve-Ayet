
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';

abstract class ISelectDhikrEvent{}

class SelectDhikrEventLoadData extends ISelectDhikrEvent{}

class SelectDhikrEventShowDetails extends ISelectDhikrEvent{
  final bool showDetails;
  SelectDhikrEventShowDetails({required this.showDetails});
}

class SelectDhikrEventSelectItem extends ISelectDhikrEvent{
  final PrayerDhikr prayer;
  SelectDhikrEventSelectItem({required this.prayer});
}


