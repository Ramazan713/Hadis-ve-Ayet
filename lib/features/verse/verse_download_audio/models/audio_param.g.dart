// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioParam _$AudioParamFromJson(Map<String, dynamic> json) => AudioParam(
      mealId: json['mealId'] as int,
      cuzNo: json['cuzNo'] as int,
      pageNo: json['pageNo'] as int,
      surahId: json['surahId'] as int,
      option: $enumDecode(_$QuranAudioOptionEnumMap, json['option']),
    );

Map<String, dynamic> _$AudioParamToJson(AudioParam instance) =>
    <String, dynamic>{
      'mealId': instance.mealId,
      'cuzNo': instance.cuzNo,
      'pageNo': instance.pageNo,
      'surahId': instance.surahId,
      'option': _$QuranAudioOptionEnumMap[instance.option]!,
    };

const _$QuranAudioOptionEnumMap = {
  QuranAudioOption.cuz: 'cuz',
  QuranAudioOption.surah: 'surah',
  QuranAudioOption.page: 'page',
  QuranAudioOption.verse: 'verse',
};
