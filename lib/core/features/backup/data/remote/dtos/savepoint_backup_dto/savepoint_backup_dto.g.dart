// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savepoint_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavePointBackupDtoImpl _$$SavePointBackupDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SavePointBackupDtoImpl(
      id: json['id'] as int?,
      itemIndexPos: json['itemIndexPos'] as int,
      title: json['title'] as String,
      autoType: json['autoType'] as int,
      modifiedDate: json['modifiedDate'] as String,
      savePointType: json['savePointType'] as int,
      bookIdBinary: json['bookIdBinary'] as int,
      parentName: json['parentName'] as String,
      parentKey: json['parentKey'] as String,
    );

Map<String, dynamic> _$$SavePointBackupDtoImplToJson(
        _$SavePointBackupDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemIndexPos': instance.itemIndexPos,
      'title': instance.title,
      'autoType': instance.autoType,
      'modifiedDate': instance.modifiedDate,
      'savePointType': instance.savePointType,
      'bookIdBinary': instance.bookIdBinary,
      'parentName': instance.parentName,
      'parentKey': instance.parentKey,
    };
