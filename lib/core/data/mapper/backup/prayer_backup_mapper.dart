

import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_backup_dto/prayer_backup_dto.dart';

extension PrayerEntityExt on PrayerEntity{
  PrayerBackupDto toPrayerBackupDto(){
    return PrayerBackupDto(
      id: id,
      name: name,
      orderItem: orderItem,
      typeId: typeId,
      source: source,
      arabicContent: arabicContent,
      isRemovable: isRemovable,
      pronunciationContent: pronunciationContent,
      meaningContent: meaningContent,
      counterId: counterId
    );
  }
}


extension PrayerBackupDtoExt on PrayerBackupDto{
  PrayerEntity toPrayerEntity(){
    return PrayerEntity(
      id: id,
      name: name,
      orderItem: orderItem,
      typeId: typeId,
      source: source,
      arabicContent: arabicContent,
      isRemovable: isRemovable,
      pronunciationContent: pronunciationContent,
      meaningContent: meaningContent,
      counterId: counterId,
      parentPrayerId: parentPrayerId,
      updateCounter: false
    );
  }
}