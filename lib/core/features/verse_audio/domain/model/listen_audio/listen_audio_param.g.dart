// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listen_audio_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListenAudioParam _$ListenAudioParamFromJson(Map<String, dynamic> json) =>
    ListenAudioParam(
      identifier: json['identifier'] as String,
      itemId: json['itemId'] as int,
      op: $enumDecode(_$QuranAudioOptionEnumMap, json['op']),
      startVerseId: json['startVerseId'] as int?,
    );

Map<String, dynamic> _$ListenAudioParamToJson(ListenAudioParam instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'itemId': instance.itemId,
      'op': _$QuranAudioOptionEnumMap[instance.op]!,
      'startVerseId': instance.startVerseId,
    };

const _$QuranAudioOptionEnumMap = {
  QuranAudioOption.cuz: 'cuz',
  QuranAudioOption.surah: 'surah',
  QuranAudioOption.page: 'page',
  QuranAudioOption.verse: 'verse',
};
