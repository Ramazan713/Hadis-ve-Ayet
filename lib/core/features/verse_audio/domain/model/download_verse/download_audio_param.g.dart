// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_audio_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadAudioParam _$DownloadAudioParamFromJson(Map<String, dynamic> json) =>
    DownloadAudioParam(
      identifier: json['identifier'] as String,
      itemIdForOption: json['itemIdForOption'] as int,
      op: $enumDecode(_$QuranAudioOptionEnumMap, json['op']),
      audioQualityEnum:
          $enumDecode(_$AudioQualityEnumEnumMap, json['audioQualityEnum']),
      startVerseId: json['startVerseId'] as int?,
    );

Map<String, dynamic> _$DownloadAudioParamToJson(DownloadAudioParam instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'itemIdForOption': instance.itemIdForOption,
      'op': _$QuranAudioOptionEnumMap[instance.op]!,
      'startVerseId': instance.startVerseId,
      'audioQualityEnum': _$AudioQualityEnumEnumMap[instance.audioQualityEnum]!,
    };

const _$QuranAudioOptionEnumMap = {
  QuranAudioOption.cuz: 'cuz',
  QuranAudioOption.surah: 'surah',
  QuranAudioOption.page: 'page',
  QuranAudioOption.verse: 'verse',
};

const _$AudioQualityEnumEnumMap = {
  AudioQualityEnum.q32: 'q32',
  AudioQualityEnum.q48: 'q48',
  AudioQualityEnum.q64: 'q64',
  AudioQualityEnum.q128: 'q128',
  AudioQualityEnum.q192: 'q192',
};
