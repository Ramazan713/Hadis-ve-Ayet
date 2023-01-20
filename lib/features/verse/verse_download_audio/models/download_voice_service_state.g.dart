// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_voice_service_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadVoiceServiceState _$DownloadVoiceServiceStateFromJson(
        Map<String, dynamic> json) =>
    DownloadVoiceServiceState(
      current: json['current'] as int,
      total: json['total'] as int,
      voiceModel: json['voiceModel'] == null
          ? null
          : DownloadVoiceEntity.fromJson(
              json['voiceModel'] as Map<String, dynamic>),
      downloadEnum: $enumDecode(_$DownloadEnumEnumMap, json['downloadEnum']),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$DownloadVoiceServiceStateToJson(
        DownloadVoiceServiceState instance) =>
    <String, dynamic>{
      'current': instance.current,
      'total': instance.total,
      'error': instance.error,
      'downloadEnum': _$DownloadEnumEnumMap[instance.downloadEnum]!,
      'voiceModel': instance.voiceModel?.toJson(),
    };

const _$DownloadEnumEnumMap = {
  DownloadEnum.downloading: 'downloading',
  DownloadEnum.pause: 'pause',
  DownloadEnum.success: 'success',
  DownloadEnum.idle: 'idle',
  DownloadEnum.error: 'error',
  DownloadEnum.retry: 'retry',
};
