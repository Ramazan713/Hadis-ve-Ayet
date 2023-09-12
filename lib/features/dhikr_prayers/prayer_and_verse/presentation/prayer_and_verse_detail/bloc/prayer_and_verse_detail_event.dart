
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';

abstract class IPrayerDetailEvent{}

class PrayerAndVerseDetailEventLoadData extends IPrayerDetailEvent{
  final int prayerId;
  PrayerAndVerseDetailEventLoadData({required this.prayerId});
}

class  PrayerAndVerseDetailEventAddToCustomPrayer extends IPrayerDetailEvent{}

class PrayerAndVerseDetailEventClearMessage extends IPrayerDetailEvent{}

class PrayerAndVerseDetailEventListenFontSize extends IPrayerDetailEvent{}