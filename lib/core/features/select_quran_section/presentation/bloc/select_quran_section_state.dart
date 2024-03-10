


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_content/select_quran_content.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_model/select_quran_model.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_result/select_quran_section_result.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
part 'select_quran_section_state.freezed.dart';

@freezed
class SelectQuranSectionState with _$SelectQuranSectionState{
  const SelectQuranSectionState._();

  const factory SelectQuranSectionState({
    required bool isLoading,
    required List<Cuz> cuzs,
    required List<Surah> surahes,
    required List<VerseNumber> verseNumbers,
    required bool showAutoGenerateNameButton,
    required int maxPage,
    required int page,
    Cuz? selectedCuz,
    Surah? selectedSurah,
    VerseNumber? firstSelectedVerseNumber,
    VerseNumber? lastSelectedVerseNumber,
    String? meaningContent,
    String? arabicContent,
    String? message,
    String? generatedName,
    SelectQuranSectionResult? result
  }) = _SelectQuranSectionState;
  
  static SelectQuranSectionState init(){
    return const SelectQuranSectionState(
      showAutoGenerateNameButton: true,
      isLoading: false,
      cuzs: [],
      surahes: [],
      verseNumbers: [],
      page: 0,
      maxPage: 1
    );
  }

  SelectQuranSectionState fromSelectVerse({
    required SelectQuranModel selectVerse,
    required SelectQuranContent? quranData,
    bool isLoading = false
  }){
    return copyWith(
      verseNumbers: selectVerse.validVerseNumbers,
      selectedCuz: selectVerse.cuz,
      selectedSurah: selectVerse.surah,
      isLoading: isLoading,
      firstSelectedVerseNumber: selectVerse.firstVerseNumber,
      lastSelectedVerseNumber: selectVerse.lastVerseNumber,
      arabicContent: quranData?.arabicContent,
      meaningContent: quranData?.meaningContent,
      page: selectVerse.page,
    );
  }
}