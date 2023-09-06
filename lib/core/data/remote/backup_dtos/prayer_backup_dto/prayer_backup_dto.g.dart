// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PrayerBackupDto _$$_PrayerBackupDtoFromJson(Map<String, dynamic> json) =>
    _$_PrayerBackupDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      arabicContent: json['arabicContent'] as String?,
      meaningContent: json['meaningContent'] as String?,
      pronunciationContent: json['pronunciationContent'] as String?,
      source: json['source'] as String?,
      counterId: json['counterId'] as int?,
      parentPrayerId: json['parentPrayerId'] as int?,
      typeId: json['typeId'] as int,
      orderItem: json['orderItem'] as int,
      isRemovable: json['isRemovable'] as bool,
    );

Map<String, dynamic> _$$_PrayerBackupDtoToJson(_$_PrayerBackupDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'arabicContent': instance.arabicContent,
      'meaningContent': instance.meaningContent,
      'pronunciationContent': instance.pronunciationContent,
      'source': instance.source,
      'counterId': instance.counterId,
      'parentPrayerId': instance.parentPrayerId,
      'typeId': instance.typeId,
      'orderItem': instance.orderItem,
      'isRemovable': instance.isRemovable,
    };
