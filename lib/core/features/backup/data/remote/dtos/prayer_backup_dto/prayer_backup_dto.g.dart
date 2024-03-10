// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrayerBackupDtoImpl _$$PrayerBackupDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PrayerBackupDtoImpl(
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
      prayerVerseBackups: (json['prayerVerseBackups'] as List<dynamic>)
          .map((e) => PrayerVerseBackupDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PrayerBackupDtoImplToJson(
        _$PrayerBackupDtoImpl instance) =>
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
      'prayerVerseBackups': instance.prayerVerseBackups,
    };
