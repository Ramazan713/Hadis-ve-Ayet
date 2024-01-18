


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'prayer_quran_data.freezed.dart';

@freezed
class PrayerQuranData with _$PrayerQuranData{
  const factory PrayerQuranData({
    required String arabicContent,
    required String meaningContent
  }) = _PrayerQuranData;
}