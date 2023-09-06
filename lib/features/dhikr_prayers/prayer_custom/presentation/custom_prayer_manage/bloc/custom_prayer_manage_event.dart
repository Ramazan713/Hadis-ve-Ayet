

import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';

abstract class ICustomPrayerManageEvent{}

class CustomPrayerManageEventLoadData extends ICustomPrayerManageEvent{
  final int? prayerId;
  CustomPrayerManageEventLoadData({required this.prayerId});
}

class CustomPrayerManageEventClearMessage extends ICustomPrayerManageEvent{}

class CustomPrayerManageEventClearNavigateBack extends ICustomPrayerManageEvent{}


class CustomPrayerManageEventUpdate extends ICustomPrayerManageEvent{
  final String newName;
  final String? newContent;
  final String? newArabicContent;
  final String? newSource;
  final String? newMeaning;

  CustomPrayerManageEventUpdate({
    required this.newName,
    this.newArabicContent,
    this.newContent,
    this.newSource,
    this.newMeaning,
  });
}


