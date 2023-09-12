
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'prayer_in_quran.freezed.dart';

@freezed
class PrayerInQuran with _$PrayerInQuran{

  const factory PrayerInQuran({
    required int id,
    required String arabicContent,
    required String meaningContent,
    required String source,
    required int orderItem,
    int? counterId,
    int? parentPrayerId
  }) = _PrayerInQuran;

}