

import 'package:hadith/core/data/local/entities/esmaul_husna_entity.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';

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

}