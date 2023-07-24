// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_downloaded_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseDownloadedVoiceModel _$VerseDownloadedVoiceModelFromJson(
        Map<String, dynamic> json) =>
    VerseDownloadedVoiceModel(
      verseId: json['verseId'] as int,
      surahId: json['surahId'] as int,
      surahName: json['surahName'] as String,
      mealId: json['mealId'] as int,
      verseNumberTr: json['verseNumberTr'] as int,
      cuzNo: json['cuzNo'] as int,
      pageNo: json['pageNo'] as int,
    );

Map<String, dynamic> _$VerseDownloadedVoiceModelToJson(
        VerseDownloadedVoiceModel instance) =>
    <String, dynamic>{
      'verseId': instance.verseId,
      'mealId': instance.mealId,
      'verseNumberTr': instance.verseNumberTr,
      'surahId': instance.surahId,
      'surahName': instance.surahName,
      'cuzNo': instance.cuzNo,
      'pageNo': instance.pageNo,
    };
