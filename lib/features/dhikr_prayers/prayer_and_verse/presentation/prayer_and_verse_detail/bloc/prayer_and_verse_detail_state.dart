
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';
part 'prayer_and_verse_detail_state.freezed.dart';

@freezed
class PrayerAndVerseDetailState with _$PrayerAndVerseDetailState{
  const factory PrayerAndVerseDetailState({
    PrayerAndVerse? prayer,
    required bool isExpandedArabic,
    required bool isExpandedPronunciation,
    required bool isExpandedMeaning,
    required FontModel fontModel,
    String? message
  }) = _PrayerAndVerseDetailState;

  static PrayerAndVerseDetailState init(){
    return PrayerAndVerseDetailState(
      isExpandedArabic: true,
      isExpandedMeaning: true,
      isExpandedPronunciation: true,
      fontModel: FontModel.init()
    );
  }

}