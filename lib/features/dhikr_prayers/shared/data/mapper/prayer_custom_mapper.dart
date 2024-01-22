

import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/features/share/domain/models/share_verse_content/share_verse_content.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

extension PrayerCustomExt on PrayerCustom{

  ShareVerseContent toShareContent(){
    return ShareVerseContent(
        title: name,
        arabicContent: arabicContent,
        meaningContent: meaningContent,
        content: pronunciationContent,
        others: {
          "Kaynak": source
        }
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
        source: source,
        isRemovable: true,
        typeId: PrayerTypeEnum.custom.typeId,
        counterId: counterId,
        updateCounter: updateCounter,
        parentPrayerId: parentPrayerId
    );
  }

  CounterEntity toCounterEntity({
    required int orderItem,
    int? counterId,
    int lastCounter = 0,
    int? typeId,
    int? goal
  }){
    return CounterEntity(
        id: counterId,
        name: name ?? "",
        orderItem: orderItem,
        lastCounter: lastCounter,
        typeId: typeId ?? CounterType.classic.typeId,
        meaning: meaningContent,
        content: pronunciationContent,
        arabicContent: arabicContent,
        description: source,
        goal: goal,
        prayerId: id
    );
  }
}