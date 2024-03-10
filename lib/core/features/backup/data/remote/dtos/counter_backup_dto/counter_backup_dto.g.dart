// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CounterBackupDtoImpl _$$CounterBackupDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CounterBackupDtoImpl(
      id: json['id'] as int?,
      content: json['content'] as String?,
      arabicContent: json['arabicContent'] as String?,
      meaning: json['meaning'] as String?,
      description: json['description'] as String?,
      goal: json['goal'] as int?,
      prayerId: json['prayerId'] as int?,
      name: json['name'] as String,
      orderItem: json['orderItem'] as int,
      lastCounter: json['lastCounter'] as int,
      type: json['type'] as int,
    );

Map<String, dynamic> _$$CounterBackupDtoImplToJson(
        _$CounterBackupDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'arabicContent': instance.arabicContent,
      'meaning': instance.meaning,
      'description': instance.description,
      'goal': instance.goal,
      'prayerId': instance.prayerId,
      'name': instance.name,
      'orderItem': instance.orderItem,
      'lastCounter': instance.lastCounter,
      'type': instance.type,
    };
