

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'prayer_custom.freezed.dart';

@freezed
class PrayerCustom with _$PrayerCustom{
  const factory PrayerCustom({
    int? id,
    required String name,
    String? arabicContent,
    String? meaningContent,
    String? pronunciationContent,
    String? source,
    @Default(0) int orderItem,
  }) = _PrayerCustom;
}