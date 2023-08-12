


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';
part 'prayer_and_verse_list_state.freezed.dart';

@freezed
class PrayerAndVerseListState with _$PrayerAndVerseListState{
  const factory PrayerAndVerseListState({
    required List<PrayerAndVerse> items,
    @Default(false) bool isLoading
  }) = _PrayerAndVerseListState;
  
  static PrayerAndVerseListState init(){
    return PrayerAndVerseListState(
        items: [],
        isLoading: false
    );
  }
  
}