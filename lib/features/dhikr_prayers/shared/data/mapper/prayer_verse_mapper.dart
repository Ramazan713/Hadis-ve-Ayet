

import 'package:hadith/core/data/local/entities/prayer_verse_entity.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_verse_cross_ref/prayer_verse_cross_ref.dart';

extension PrayerVerseCrossRefExt on PrayerVerseCrossRef{
  PrayerVerseEntity toPrayerVerseEntity(){
    return PrayerVerseEntity(
      id: id,
      prayerId: prayerId,
      orderItem: orderItem,
      verseId: verseId
    );
  }
}

extension PrayerVerseEntityExt on PrayerVerseEntity{
  PrayerVerseCrossRef toPrayerVerseCrossRef(){
    return PrayerVerseCrossRef(
      id: id,
      prayerId: prayerId,
      orderItem: orderItem,
      verseId: verseId
    );
  }
}