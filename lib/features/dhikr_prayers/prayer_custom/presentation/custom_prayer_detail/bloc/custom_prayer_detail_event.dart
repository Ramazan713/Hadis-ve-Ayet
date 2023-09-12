
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

abstract class ICustomPrayerDetailEvent{}

class CustomPrayerDetailLoadData extends ICustomPrayerDetailEvent{
  final int prayerId;
  CustomPrayerDetailLoadData({required this.prayerId});
}

class CustomPrayerDetailEventAddDhikr extends ICustomPrayerDetailEvent{
  final PrayerCustom prayer;
  CustomPrayerDetailEventAddDhikr({required this.prayer});
}

class CustomPrayerDetailEventClearMessage extends ICustomPrayerDetailEvent{}

class CustomPrayerDetailEventListenFontSize extends ICustomPrayerDetailEvent{}