

import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/features/share/domain/models/share_verse_content/share_verse_content.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran/prayer_in_quran.dart';

extension PrayerInQuranExt on PrayerInQuran{

  PrayerCustom toPrayerCustom(){
    return PrayerCustom(
      id: id,
      name: source,
      arabicContent: arabicContent,
      meaningContent: meaningContent,
      orderItem: orderItem,
      counterId: counterId,
      updateCounter: false,
      parentPrayerId: parentPrayerId,
      source: source,
    );
  }

  ShareVerseContent toShareContent(){
    return ShareVerseContent(
      title: source,
      arabicContent: arabicContent,
      meaningContent: meaningContent,
    );
  }

  PrayerEntity toPrayerEntity(){
    return PrayerEntity(
        id: id,
        name: null,
        arabicContent: arabicContent,
        meaningContent: meaningContent,
        pronunciationContent: null,
        orderItem: orderItem,
        isRemovable: false,
        typeId: PrayerTypeEnum.prayerInQuran.typeId,
        counterId: counterId,
        parentPrayerId: parentPrayerId,
        source: source,
        updateCounter: false
    );
  }
}
