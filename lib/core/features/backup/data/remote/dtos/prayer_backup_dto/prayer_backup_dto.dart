
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/prayer_verse_backup_dto/prayer_verse_backup_dto.dart';
part 'prayer_backup_dto.freezed.dart';
part 'prayer_backup_dto.g.dart';

@freezed
class PrayerBackupDto with _$PrayerBackupDto{
  const factory PrayerBackupDto({
    int? id,
    String? name,
    String? arabicContent,
    String? meaningContent,
    String? pronunciationContent,
    String? source,
    int? counterId,
    int? parentPrayerId,
    required int typeId,
    required int orderItem,
    required bool isRemovable,
    required List<PrayerVerseBackupDto> prayerVerseBackups
  }) = _PrayerBackupDto;

  factory PrayerBackupDto.fromJson(Map<String, Object?> json) => _$PrayerBackupDtoFromJson(json);
}