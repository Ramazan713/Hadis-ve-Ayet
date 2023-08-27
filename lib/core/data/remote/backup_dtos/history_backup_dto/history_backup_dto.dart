

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'history_backup_dto.freezed.dart';
part 'history_backup_dto.g.dart';

@freezed
class HistoryBackupDto with _$HistoryBackupDto{
  const factory HistoryBackupDto({
    required int? id,
    required String name,
    required int originType,
    required String modifiedDate
  }) = _HistoryBackupDto;

  factory HistoryBackupDto.fromJson(Map<String, Object?> json) => _$HistoryBackupDtoFromJson(json);
}