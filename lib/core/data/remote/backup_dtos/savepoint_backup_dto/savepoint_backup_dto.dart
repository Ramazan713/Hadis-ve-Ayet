
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'savepoint_backup_dto.freezed.dart';
part 'savepoint_backup_dto.g.dart';

@freezed
class SavePointBackupDto with _$SavePointBackupDto{
  const factory SavePointBackupDto({
    int? id,
    required int itemIndexPos,
    required String title,
    required int autoType,
    required String modifiedDate,
    required int savePointType,
    required int bookScope,
    required String parentName,
    required String parentKey
  }) = _SavePointBackupDto;

  factory SavePointBackupDto.fromJson(Map<String, Object?> json) => _$SavePointBackupDtoFromJson(json);
}