

import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/data/remote/backup_dtos/counter_backup_dto/counter_backup_dto.dart';


extension CounterBackupDtoExt on CounterBackupDto{
  CounterEntity toCounterEntity(){
    return CounterEntity(
      id: id,
      name: name,
      typeId: typeId,
      lastCounter: lastCounter,
      orderItem: orderItem,
      description: description,
      meaning: meaning,
      content: content,
      goal: goal,
      arabicContent: arabicContent
    );
  }
}


extension CounterEntityExt on CounterEntity{
  CounterBackupDto toCounterBackupDto(){
    return CounterBackupDto(
        id: id,
        name: name,
        typeId: typeId,
        lastCounter: lastCounter,
        orderItem: orderItem,
        description: description,
        meaning: meaning,
        content: content,
        goal: goal,
        arabicContent: arabicContent
    );
  }
}