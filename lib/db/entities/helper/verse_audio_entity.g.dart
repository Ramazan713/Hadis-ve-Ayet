// GENERATED CODE - DO NOT MODIFY BY HAND

part of './verse_audio_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseAudioEntity _$VerseAudioEntityFromJson(Map<String, dynamic> json) =>
    VerseAudioEntity(
      surahName: json['surahName'] as String,
      surahId: json['surahId'] as int,
      identifier: json['identifier'] as String,
      fileName: json['fileName'] as String?,
      cuzNo: json['cuzNo'] as int,
      pageNo: json['pageNo'] as int,
      verseNumber: json['verseNumber'] as String,
      mealId: json['mealId'] as int,
      editionName: json['editionName'] as String,
    );

Map<String, dynamic> _$VerseAudioEntityToJson(VerseAudioEntity instance) =>
    <String, dynamic>{
      'mealId': instance.mealId,
      'surahName': instance.surahName,
      'surahId': instance.surahId,
      'identifier': instance.identifier,
      'editionName': instance.editionName,
      'fileName': instance.fileName,
      'cuzNo': instance.cuzNo,
      'pageNo': instance.pageNo,
      'verseNumber': instance.verseNumber,
    };
