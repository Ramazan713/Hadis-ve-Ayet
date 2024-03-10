// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_savepoint_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopicSavePointBackupDtoImpl _$$TopicSavePointBackupDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$TopicSavePointBackupDtoImpl(
      id: json['id'] as int?,
      pos: json['pos'] as int,
      type: json['type'] as int,
      parentKey: json['parentKey'] as String,
    );

Map<String, dynamic> _$$TopicSavePointBackupDtoImplToJson(
        _$TopicSavePointBackupDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pos': instance.pos,
      'type': instance.type,
      'parentKey': instance.parentKey,
    };
