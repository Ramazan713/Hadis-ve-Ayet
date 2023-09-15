

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'prayer_custom.freezed.dart';

@freezed
class PrayerCustom with _$PrayerCustom{

  const PrayerCustom._();

  const factory PrayerCustom({
    int? id,
    required String name,
    String? arabicContent,
    String? meaningContent,
    String? pronunciationContent,
    String? source,
    @Default(0) int orderItem,
    @Default(false) updateCounter,
    int? counterId,
    int? parentPrayerId
  }) = _PrayerCustom;

  bool get hasArabicContent => arabicContent != null &&
      (arabicContent ?? "").isNotEmpty;

  bool get hasContent =>  pronunciationContent != null &&
      (pronunciationContent ?? "").isNotEmpty;

  bool get hasMeaning =>  meaningContent != null && (meaningContent ?? "").isNotEmpty;

  bool get hasSource =>  source != null && (source ?? "").isNotEmpty;

  bool get hasAnyData => hasArabicContent || hasContent || hasMeaning;
}