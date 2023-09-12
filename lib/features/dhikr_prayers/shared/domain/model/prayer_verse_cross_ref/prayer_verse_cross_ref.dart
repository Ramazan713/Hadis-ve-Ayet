
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'prayer_verse_cross_ref.freezed.dart';

@freezed
class PrayerVerseCrossRef with _$PrayerVerseCrossRef{
  const factory PrayerVerseCrossRef({
    required int verseId,
    required int prayerId,
    required int orderItem,
    int? id,
  }) = _PrayerVerseCrossRef;
}
