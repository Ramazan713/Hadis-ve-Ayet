

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/features/verses/shared/domain/models/select_page_result/select_page_result.dart';
import 'package:hadith/core/features/verses/domain/model/select_verse_model/select_verse_model.dart';
import 'package:hadith/core/features/verses/domain/model/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
part 'select_verse_page_state.freezed.dart';

@freezed
class SelectVersePageState with _$SelectVersePageState{
  const SelectVersePageState._();

  const factory SelectVersePageState({
    required bool isLoading,
    required List<Cuz> cuzs,
    required List<Surah> surahes,
    required List<VerseNumber> verseNumbers,
    required int maxPage,
    required int page,
    Cuz? selectedCuz,
    Surah? selectedSurah,
    VerseNumber? selectedVerseNumber,
    String? message,
    SelectPageResult? selectResult
  }) = _SelectVersePageState;

  static SelectVersePageState init(){
    return const SelectVersePageState(
      isLoading: false,
      cuzs: [],
      surahes: [],
      verseNumbers: [],
      page: 0,
      maxPage: 1
    );
  }

  SelectVersePageState fromSelectVerse({
    required SelectVerseModel selectVerse,
    bool isLoading = false
  }){
    return copyWith(
        verseNumbers: selectVerse.validVerseNumbers,
        selectedCuz: selectVerse.cuz,
        selectedSurah: selectVerse.surah,
        selectedVerseNumber: selectVerse.currentVerseNumber,
        page: selectVerse.page,
        isLoading: isLoading
    );
  }

}