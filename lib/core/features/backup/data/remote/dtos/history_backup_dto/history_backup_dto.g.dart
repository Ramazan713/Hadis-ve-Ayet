// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryBackupDtoImpl _$$HistoryBackupDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$HistoryBackupDtoImpl(
      id: json['id'] as int?,
      name: json['name'] as String,
      originType: json['originType'] as int,
      modifiedDate: json['modifiedDate'] as String,
    );

Map<String, dynamic> _$$HistoryBackupDtoImplToJson(
        _$HistoryBackupDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'originType': instance.originType,
      'modifiedDate': instance.modifiedDate,
    };
