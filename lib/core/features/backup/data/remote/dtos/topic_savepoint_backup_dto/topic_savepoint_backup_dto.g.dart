// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_savepoint_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TopicSavePointBackupDto _$$_TopicSavePointBackupDtoFromJson(
        Map<String, dynamic> json) =>
    _$_TopicSavePointBackupDto(
      id: json['id'] as int?,
      pos: json['pos'] as int,
      type: json['type'] as int,
      parentKey: json['parentKey'] as String,
    );

Map<String, dynamic> _$$_TopicSavePointBackupDtoToJson(
        _$_TopicSavePointBackupDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pos': instance.pos,
      'type': instance.type,
      'parentKey': instance.parentKey,
    };
