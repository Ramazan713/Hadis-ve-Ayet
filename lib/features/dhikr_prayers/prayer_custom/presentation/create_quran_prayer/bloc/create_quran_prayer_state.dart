

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/core/features/verses/domain/model/verse_number.dart';
part 'create_quran_prayer_state.freezed.dart';

@freezed
class CreateQuranPrayerState with _$CreateQuranPrayerState{
  const factory CreateQuranPrayerState({
    required bool navigateBack,
    required bool isLoading,
    required List<Cuz> cuzs,
    required List<Surah> surahes,
    required List<VerseNumber> verseNumbers,
    required bool showAutoGenerateNameButton,
    Cuz? selectedCuz,
    Surah? selectedSurah,
    VerseNumber? firstSelectedVerseNumber,
    VerseNumber? lastSelectedVerseNumber,
    String? meaningContent,
    String? arabicContent,
    String? message,
    String? generatedName
  }) = _CreateQuranPrayerState;

  static CreateQuranPrayerState init(){
    return const CreateQuranPrayerState(
      showAutoGenerateNameButton: true,
      isLoading: false,
      navigateBack: false,
      cuzs: [],
      surahes: [],
      verseNumbers: []
    );
  }

}