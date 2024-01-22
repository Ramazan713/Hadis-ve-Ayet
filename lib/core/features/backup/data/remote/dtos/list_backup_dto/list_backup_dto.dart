
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'list_backup_dto.freezed.dart';
part 'list_backup_dto.g.dart';

@freezed
class ListBackupDto with _$ListBackupDto{
  const factory ListBackupDto({
    int? id,
    required String name,
    required bool isRemovable,
    required int sourceId,
    required bool isArchive,
    required int pos
  }) = _ListBackupDto;

  factory ListBackupDto.fromJson(Map<String, Object?> json) => _$ListBackupDtoFromJson(json);
}