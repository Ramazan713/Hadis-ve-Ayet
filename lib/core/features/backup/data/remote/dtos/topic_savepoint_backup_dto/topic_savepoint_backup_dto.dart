
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'topic_savepoint_backup_dto.freezed.dart';
part 'topic_savepoint_backup_dto.g.dart';

@freezed
class TopicSavePointBackupDto with _$TopicSavePointBackupDto{
  const factory TopicSavePointBackupDto({
    int? id,
    required int pos,
    required int type,
    required String parentKey
  }) = _TopicSavePointBackupDto;

  factory TopicSavePointBackupDto.fromJson(Map<String, Object?> json) => _$TopicSavePointBackupDtoFromJson(json);
}