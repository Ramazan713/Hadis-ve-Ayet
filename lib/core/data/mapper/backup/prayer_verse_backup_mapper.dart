


import 'package:hadith/core/data/local/entities/prayer_verse_entity.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_verse_backup_dto/prayer_verse_backup_dto.dart';

extension PrayerVerseEntityExt on PrayerVerseEntity{
  PrayerVerseBackupDto toPrayerVerseBackupDto(){
    return PrayerVerseBackupDto(
      verseId: verseId,
      orderItem: orderItem,
      prayerId: prayerId,
    );
  }
}


extension PrayerVerseBackupDtoExt on PrayerVerseBackupDto{
  PrayerVerseEntity toPrayerVerseEntity(){
    return PrayerVerseEntity(
      verseId: verseId,
      orderItem: orderItem,
      prayerId: prayerId,
      id: null
    );
  }
}