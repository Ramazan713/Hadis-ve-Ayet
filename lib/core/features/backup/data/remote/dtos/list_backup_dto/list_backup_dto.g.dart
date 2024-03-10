// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListBackupDtoImpl _$$ListBackupDtoImplFromJson(Map<String, dynamic> json) =>
    _$ListBackupDtoImpl(
      id: json['id'] as int?,
      name: json['name'] as String,
      isRemovable: json['isRemovable'] as bool,
      sourceId: json['sourceId'] as int,
      isArchive: json['isArchive'] as bool,
      pos: json['pos'] as int,
    );

Map<String, dynamic> _$$ListBackupDtoImplToJson(_$ListBackupDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isRemovable': instance.isRemovable,
      'sourceId': instance.sourceId,
      'isArchive': instance.isArchive,
      'pos': instance.pos,
    };
