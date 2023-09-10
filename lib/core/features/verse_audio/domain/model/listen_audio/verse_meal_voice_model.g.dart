// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_meal_voice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseMealVoiceModel _$VerseMealVoiceModelFromJson(Map<String, dynamic> json) =>
    VerseMealVoiceModel(
      surahName: json['surahName'] as String,
      surahId: json['surahId'] as int,
      identifier: json['identifier'] as String,
      fileName: json['fileName'] as String?,
      cuzNo: json['cuzNo'] as int,
      pageNo: json['pageNo'] as int,
      verseNumbers: json['verseNumbers'] as String,
      mealId: json['mealId'] as int,
      editionName: json['editionName'] as String,
      cuzName: json['cuzName'] as String,
    );

Map<String, dynamic> _$VerseMealVoiceModelToJson(
        VerseMealVoiceModel instance) =>
    <String, dynamic>{
      'mealId': instance.mealId,
      'surahName': instance.surahName,
      'surahId': instance.surahId,
      'identifier': instance.identifier,
      'editionName': instance.editionName,
      'fileName': instance.fileName,
      'cuzNo': instance.cuzNo,
      'cuzName': instance.cuzName,
      'pageNo': instance.pageNo,
      'verseNumbers': instance.verseNumbers,
    };
