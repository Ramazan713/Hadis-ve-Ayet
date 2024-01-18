import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';

extension PrayerDhikrCustomEx on PrayerDhikr{
  PrayerCustom toPrayerCustom({
    int? id,
  }){
    return PrayerCustom(
      name: name,
      meaningContent: meaningContent,
      arabicContent: arabicContent,
      pronunciationContent: pronunciationContent,
      id: id,
    );
  }
}