

import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/features/share/domain/models/share_verse_content/share_verse_content.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

extension PrayerAndVerseExt on PrayerAndVerse{

  PrayerCustom toPrayerCustom(){
    return PrayerCustom(
        id: id,
        name: name,
        arabicContent: arabicContent,
        meaningContent: meaningContent,
        pronunciationContent: pronunciationContent,
        orderItem: orderItem,
        counterId: counterId,
        updateCounter: false,
        parentPrayerId: parentPrayerId
    );
  }

  ShareVerseContent toShareContent(){
    return ShareVerseContent(
      title: name,
      arabicContent: arabicContent,
      meaningContent: meaningContent,
      content: pronunciationContent,
    );
  }

  PrayerEntity toPrayerEntity(){
    return PrayerEntity(
        id: id,
        name: name,
        arabicContent: arabicContent,
        meaningContent: meaningContent,
        pronunciationContent: pronunciationContent,
        orderItem: orderItem,
        isRemovable: false,
        typeId: PrayerTypeEnum.prayerAndVerses.typeId,
        counterId: counterId,
        parentPrayerId: parentPrayerId,
        source: null,
        updateCounter: false
    );
  }
}