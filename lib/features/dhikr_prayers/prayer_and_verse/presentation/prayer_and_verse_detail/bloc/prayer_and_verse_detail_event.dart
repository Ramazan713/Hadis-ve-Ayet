
abstract class IPrayerDetailEvent{}

class PrayerAndVerseDetailEventLoadData extends IPrayerDetailEvent{
  final int prayerId;
  PrayerAndVerseDetailEventLoadData({required this.prayerId});
}

class PrayerAndVerseDetailEventClearMessage extends IPrayerDetailEvent{}

class PrayerAndVerseDetailEventListenFontSize extends IPrayerDetailEvent{}