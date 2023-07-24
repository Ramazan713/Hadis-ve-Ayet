// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_audio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseAudioModel _$VerseAudioModelFromJson(Map<String, dynamic> json) =>
    VerseAudioModel(
      audio: json['audio'] == null
          ? null
          : VerseAudioEntityOld.fromJson(json['audio'] as Map<String, dynamic>),
      audioEnum: $enumDecode(_$AudioEnumEnumMap, json['audioEnum']),
      duration: Duration(microseconds: json['duration'] as int),
      initIndex: json['initIndex'] as int,
      position: Duration(microseconds: json['position'] as int),
      speed: (json['speed'] as num).toDouble(),
      isLoop: json['isLoop'] as bool,
      error: json['error'] as String?,
      currentIndex: json['currentIndex'] as int,
    );

Map<String, dynamic> _$VerseAudioModelToJson(VerseAudioModel instance) =>
    <String, dynamic>{
      'audio': instance.audio?.toJson(),
      'error': instance.error,
      'audioEnum': _$AudioEnumEnumMap[instance.audioEnum]!,
      'duration': instance.duration.inMicroseconds,
      'position': instance.position.inMicroseconds,
      'speed': instance.speed,
      'isLoop': instance.isLoop,
      'currentIndex': instance.currentIndex,
      'initIndex': instance.initIndex,
    };

const _$AudioEnumEnumMap = {
  AudioEnum.idle: 'idle',
  AudioEnum.running: 'running',
  AudioEnum.pause: 'pause',
  AudioEnum.finish: 'finish',
  AudioEnum.dispose: 'dispose',
};
