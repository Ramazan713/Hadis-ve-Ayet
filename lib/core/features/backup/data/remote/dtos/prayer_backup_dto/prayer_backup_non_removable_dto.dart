
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'prayer_backup_non_removable_dto.freezed.dart';
part 'prayer_backup_non_removable_dto.g.dart';

@freezed
class PrayerBackupNonRemovableDto with _$PrayerBackupNonRemovableDto{
  const factory PrayerBackupNonRemovableDto({
    required int typeId,
    required int orderItem,
    int? parentPrayerId
  }) = _PrayerBackupNonRemovableDto;

  factory PrayerBackupNonRemovableDto.fromJson(Map<String, Object?> json) => _$PrayerBackupNonRemovableDtoFromJson(json);
}