// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HistoryBackupDto _$$_HistoryBackupDtoFromJson(Map<String, dynamic> json) =>
    _$_HistoryBackupDto(
      id: json['id'] as int?,
      name: json['name'] as String,
      originType: json['originType'] as int,
      modifiedDate: json['modifiedDate'] as String,
    );

Map<String, dynamic> _$$_HistoryBackupDtoToJson(_$_HistoryBackupDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'originType': instance.originType,
      'modifiedDate': instance.modifiedDate,
    };
