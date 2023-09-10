// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_service_enum_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackgroundServiceEnumWrapper _$BackgroundServiceEnumWrapperFromJson(
        Map<String, dynamic> json) =>
    BackgroundServiceEnumWrapper(
      serviceEnum: $enumDecode(_$AudioServiceEnumEnumMap, json['serviceEnum']),
    );

Map<String, dynamic> _$BackgroundServiceEnumWrapperToJson(
        BackgroundServiceEnumWrapper instance) =>
    <String, dynamic>{
      'serviceEnum': _$AudioServiceEnumEnumMap[instance.serviceEnum]!,
    };

const _$AudioServiceEnumEnumMap = {
  AudioServiceEnum.listenAudio: 'listenAudio',
  AudioServiceEnum.downloadAudio: 'downloadAudio',
};
