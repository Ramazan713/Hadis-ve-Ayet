
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';
part 'prayer_and_verse_detail_state.freezed.dart';

@freezed
class PrayerAndVerseDetailState with _$PrayerAndVerseDetailState{
  const factory PrayerAndVerseDetailState({
    required FontModel fontModel,
    required bool isLoading,
    PrayerAndVerse? prayer,
    String? message
  }) = _PrayerAndVerseDetailState;

  static PrayerAndVerseDetailState init(){
    return PrayerAndVerseDetailState(
      fontModel: FontModel.init(),
      isLoading: false
    );
  }

}