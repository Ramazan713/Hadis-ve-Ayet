

import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';

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
      counterType: CounterType.from(typeId)
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
      orderItem: order
    );
  }
}