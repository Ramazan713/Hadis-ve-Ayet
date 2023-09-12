

import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_backup_dto/prayer_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_verse_backup_dto/prayer_verse_backup_dto.dart';

extension PrayerEntityExt on PrayerEntity{
  PrayerBackupDto toPrayerBackupDto({
    required List<PrayerVerseBackupDto> prayerVerseBackups
  }){
    return PrayerBackupDto(
      name: name,
      orderItem: orderItem,
      typeId: typeId,
      source: source,
      arabicContent: arabicContent,
      isRemovable: isRemovable,
      pronunciationContent: pronunciationContent,
      meaningContent: meaningContent,
      counterId: counterId,
      prayerVerseBackups: prayerVerseBackups
    );
  }
}


extension PrayerBackupDtoExt on PrayerBackupDto{
  PrayerEntity toPrayerEntity(){
    return PrayerEntity(
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
      updateCounter: false,
    );
  }
}