

import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/features/share/domain/models/share_verse_content/share_verse_content.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

extension CounterEntityExt on CounterEntity{

  Counter toCounter(){
    return Counter(
      id: id,
      name: name,
      meaning: meaning,
      arabicContent: arabicContent,
      content: content,
      description: description,
      lastCounter: lastCounter,
      goal: goal,
      order: orderItem,
      counterType: CounterType.from(typeId),
      prayerId: prayerId
    );
  }


}

extension CounterExt on Counter{

  CounterEntity toCounterEntity(){
    return CounterEntity(
      id: id,
      name: name,
      meaning: meaning,
      arabicContent: arabicContent,
      content: content,
      description: description,
      lastCounter: lastCounter,
      goal: goal,
      typeId: counterType.typeId,
      orderItem: order,
      prayerId: prayerId
    );
  }


  ShareVerseContent toShareContent(){
    return ShareVerseContent(
        title: name,
        content: content,
        meaningContent: meaning,
        arabicContent: arabicContent,
        others: {
          "Açıklaması": description
        }
    );
  }

  PrayerCustom toPrayer(){
    return PrayerCustom(
        id: null,
        name: name,
        meaningContent: meaning,
        arabicContent: arabicContent,
        pronunciationContent: content,
        updateCounter: false,
        counterId: id,
        source: null,
    );
  }

}