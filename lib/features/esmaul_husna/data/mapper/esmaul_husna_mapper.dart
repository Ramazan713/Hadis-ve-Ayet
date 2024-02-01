

import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/data/local/entities/esmaul_husna_entity.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';

extension EsmaulHusnaEntityExt on EsmaulHusnaEntity{

  EsmaulHusna toEsmaulHusna(){
    return EsmaulHusna(
      id: id,
      name: name,
      searchName: searchName,
      arabicName: arabicName,
      counterId: counterId,
      dhikr: dhikr,
      meaning: meaning,
      order: orderItem,
      virtue: virtue
    );
  }
}


extension EsmaulHusnaExt on EsmaulHusna{

  EsmaulHusnaEntity toEsmaulHusnaEntity(){
    return EsmaulHusnaEntity(
        id: id,
        name: name,
        arabicName: arabicName,
        counterId: counterId,
        dhikr: dhikr,
        meaning: meaning,
        orderItem: order,
        virtue: virtue,
        searchName: searchName
    );
  }

  CounterEntity toCounterEntity({required int orderItem}){
    return CounterEntity(
        id: counterId,
        typeId: CounterType.classic.typeId,
        lastCounter: 0,
        orderItem: orderItem,
        name: name,
        description: virtue,
        arabicContent: arabicName,
        content: name,
        meaning: meaning,
        goal: int.tryParse(dhikr)
    );
  }

}