// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CounterBackupDto _$$_CounterBackupDtoFromJson(Map<String, dynamic> json) =>
    _$_CounterBackupDto(
      id: json['id'] as int?,
      content: json['content'] as String?,
      arabicContent: json['arabicContent'] as String?,
      meaning: json['meaning'] as String?,
      description: json['description'] as String?,
      goal: json['goal'] as int?,
      name: json['name'] as String,
      orderItem: json['orderItem'] as int,
      lastCounter: json['lastCounter'] as int,
      typeId: json['typeId'] as int,
    );

Map<String, dynamic> _$$_CounterBackupDtoToJson(_$_CounterBackupDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'arabicContent': instance.arabicContent,
      'meaning': instance.meaning,
      'description': instance.description,
      'goal': instance.goal,
      'name': instance.name,
      'orderItem': instance.orderItem,
      'lastCounter': instance.lastCounter,
      'typeId': instance.typeId,
    };
