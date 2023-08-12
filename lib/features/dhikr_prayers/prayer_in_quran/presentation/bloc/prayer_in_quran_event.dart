


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

class PrayerInQuranEventListenData extends IPrayerInQuranEvent{}

class PrayerInQuranEventListenAppPref extends IPrayerInQuranEvent{}