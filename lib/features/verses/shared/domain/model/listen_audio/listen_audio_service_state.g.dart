// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listen_audio_service_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListenAudioServiceState _$ListenAudioServiceStateFromJson(
        Map<String, dynamic> json) =>
    ListenAudioServiceState(
      audio: json['audio'] == null
          ? null
          : VerseMealVoiceModel.fromJson(json['audio'] as Map<String, dynamic>),
      audioEnum: $enumDecode(_$ListenAudioEnumEnumMap, json['audioEnum']),
      duration: Duration(microseconds: json['duration'] as int),
      position: Duration(microseconds: json['position'] as int),
      speed: (json['speed'] as num).toDouble(),
      isLoop: json['isLoop'] as bool,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ListenAudioServiceStateToJson(
        ListenAudioServiceState instance) =>
    <String, dynamic>{
      'audio': instance.audio?.toJson(),
      'error': instance.error,
      'audioEnum': _$ListenAudioEnumEnumMap[instance.audioEnum]!,
      'duration': instance.duration.inMicroseconds,
      'position': instance.position.inMicroseconds,
      'speed': instance.speed,
      'isLoop': instance.isLoop,
    };

const _$ListenAudioEnumEnumMap = {
  ListenAudioEnum.idle: 'idle',
  ListenAudioEnum.running: 'running',
  ListenAudioEnum.pause: 'pause',
  ListenAudioEnum.finish: 'finish',
};
