

import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';

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