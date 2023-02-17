

import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/model/prayer.dart';

abstract class IDetailPrayerEvent{}

class DetailPrayerEventInit extends IDetailPrayerEvent{}

class DetailPrayerEventInitExpanding extends IDetailPrayerEvent{}

class DetailPrayerEventVisibilityArabic extends IDetailPrayerEvent{
  final bool isVisible;
  DetailPrayerEventVisibilityArabic({required this.isVisible});
}

class DetailPrayerEventAddCounter extends IDetailPrayerEvent{
  final Prayer prayer;
  DetailPrayerEventAddCounter({required this.prayer});
}

class DetailPrayerEventVisibilityPronunciation extends IDetailPrayerEvent{
  final bool isVisible;
  DetailPrayerEventVisibilityPronunciation({required this.isVisible});
}

class DetailPrayerEventVisibilityMeaning extends IDetailPrayerEvent{
  final bool isVisible;
  DetailPrayerEventVisibilityMeaning({required this.isVisible});
}