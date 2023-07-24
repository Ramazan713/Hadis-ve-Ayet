// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_audio_manager_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadAudioManagerState _$DownloadAudioManagerStateFromJson(
        Map<String, dynamic> json) =>
    DownloadAudioManagerState(
      current: json['current'] as int,
      total: json['total'] as int,
      voiceModel: json['voiceModel'] == null
          ? null
          : VerseDownloadedVoiceModel.fromJson(
              json['voiceModel'] as Map<String, dynamic>),
      downloadEnum: $enumDecode(_$DownloadEnumEnumMap, json['downloadEnum']),
      error: json['error'] as String?,
      currentParam: json['currentParam'] == null
          ? null
          : DownloadAudioParam.fromJson(
              json['currentParam'] as Map<String, dynamic>),
      queueParams: (json['queueParams'] as List<dynamic>)
          .map((e) => DownloadAudioParam.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastDownloaded: json['lastDownloaded'] == null
          ? null
          : DownloadAudioParam.fromJson(
              json['lastDownloaded'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DownloadAudioManagerStateToJson(
        DownloadAudioManagerState instance) =>
    <String, dynamic>{
      'current': instance.current,
      'total': instance.total,
      'error': instance.error,
      'downloadEnum': _$DownloadEnumEnumMap[instance.downloadEnum]!,
      'voiceModel': instance.voiceModel?.toJson(),
      'currentParam': instance.currentParam?.toJson(),
      'lastDownloaded': instance.lastDownloaded?.toJson(),
      'queueParams': instance.queueParams.map((e) => e.toJson()).toList(),
    };

const _$DownloadEnumEnumMap = {
  DownloadEnum.downloading: 'downloading',
  DownloadEnum.pause: 'pause',
  DownloadEnum.successStep: 'successStep',
  DownloadEnum.idle: 'idle',
  DownloadEnum.error: 'error',
  DownloadEnum.retry: 'retry',
  DownloadEnum.successAll: 'successAll',
};
