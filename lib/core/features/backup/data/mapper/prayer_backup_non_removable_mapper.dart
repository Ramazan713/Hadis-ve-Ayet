


import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/prayer_backup_dto/prayer_backup_non_removable_dto.dart';

extension PrayerEntityExt on PrayerEntity{
  PrayerBackupNonRemovableDto toPrayerBackupNonRemovableDto(){
    return PrayerBackupNonRemovableDto(
      orderItem: orderItem,
      typeId: typeId,
      parentPrayerId: parentPrayerId
    );
  }
}