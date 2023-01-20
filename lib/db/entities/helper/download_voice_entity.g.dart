// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_voice_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadVoiceEntity _$DownloadVoiceEntityFromJson(Map<String, dynamic> json) =>
    DownloadVoiceEntity(
      surahId: json['surahId'] as int,
      verseId: json['verseId'] as int,
      verseNumber: json['verseNumber'] as int,
      cuzNo: json['cuzNo'] as int,
      surahName: json['surahName'] as String,
      mealId: json['mealId'] as int,
    );

Map<String, dynamic> _$DownloadVoiceEntityToJson(
        DownloadVoiceEntity instance) =>
    <String, dynamic>{
      'verseId': instance.verseId,
      'surahId': instance.surahId,
      'mealId': instance.mealId,
      'cuzNo': instance.cuzNo,
      'verseNumber': instance.verseNumber,
      'surahName': instance.surahName,
    };
