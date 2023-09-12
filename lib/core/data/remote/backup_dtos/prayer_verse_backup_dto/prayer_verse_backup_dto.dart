
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'prayer_verse_backup_dto.freezed.dart';
part 'prayer_verse_backup_dto.g.dart';

@freezed
class PrayerVerseBackupDto with _$PrayerVerseBackupDto{
  const factory PrayerVerseBackupDto({
    required int verseId,
    required int prayerId,
    required int orderItem
  }) = _PrayerVerseBackupDto;

  factory PrayerVerseBackupDto.fromJson(Map<String, Object?> json) => _$PrayerVerseBackupDtoFromJson(json);
}