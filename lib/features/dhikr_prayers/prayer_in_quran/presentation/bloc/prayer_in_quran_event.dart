


import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';

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
  final PrayerInQuran prayer;
  PrayerInQuranEventAddCustomPrayer({required this.prayer});
}

class PrayerInQuranEventListenData extends IPrayerInQuranEvent{}

class PrayerInQuranEventListenAppPref extends IPrayerInQuranEvent{}