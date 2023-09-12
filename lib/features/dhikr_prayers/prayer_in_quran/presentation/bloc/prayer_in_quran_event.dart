


import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran/prayer_in_quran.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';

abstract class IPrayerInQuranEvent{}

class PrayerInQuranEventClearMessage extends IPrayerInQuranEvent{}

class PrayerInQuranEventSetQuery extends IPrayerInQuranEvent{
  final String query;
  PrayerInQuranEventSetQuery({required this.query});
}

class PrayerInQuranEventSetSearchBarVisibility extends IPrayerInQuranEvent{
  final bool isVisible;
  PrayerInQuranEventSetSearchBarVisibility({required this.isVisible});
}

class PrayerInQuranEventAddCustomPrayer extends IPrayerInQuranEvent{
  final PrayerUnit<PrayerInQuran> prayerUnit;
  PrayerInQuranEventAddCustomPrayer({required this.prayerUnit});
}

class PrayerInQuranEventListenData extends IPrayerInQuranEvent{}

class PrayerInQuranEventListenAppPref extends IPrayerInQuranEvent{}