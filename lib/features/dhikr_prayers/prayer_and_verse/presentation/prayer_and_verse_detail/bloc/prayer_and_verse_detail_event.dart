
abstract class IPrayerDetailEvent{}

class PrayerDetailEventLoadData extends IPrayerDetailEvent{
  final int prayerId;
  PrayerDetailEventLoadData({required this.prayerId});
}

class PrayerDetailEventSetVisibilityArabic extends IPrayerDetailEvent{
  final bool isVisible;
  PrayerDetailEventSetVisibilityArabic({required this.isVisible});
}

class PrayerDetailEventSetVisibilityMeaning extends IPrayerDetailEvent{
  final bool isVisible;
  PrayerDetailEventSetVisibilityMeaning({required this.isVisible});
}

class PrayerDetailEventSetVisibilityPronunciation extends IPrayerDetailEvent{
  final bool isVisible;
  PrayerDetailEventSetVisibilityPronunciation({required this.isVisible});
}

class PrayerDetailEventClearMessage extends IPrayerDetailEvent{}

class PrayerDetailEventListenFontSize extends IPrayerDetailEvent{}