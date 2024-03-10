

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'select_quran_section_config.freezed.dart';

@freezed
class SelectQuranSectionConfig with _$SelectQuranSectionConfig{

  const SelectQuranSectionConfig._();

  const factory SelectQuranSectionConfig({
    @Default(true) bool showAutoName,
    @Default(true) bool showSelectJuz,
    @Default(true) bool showSelectSurah,
    @Default(true) bool showSelectPage,
    @Default(true) bool showSelectFirstVerseNumber,
    @Default(true) bool showSelectLastVerseNumber,
    @Default(true) bool showArabicContent,
    @Default(true) bool showMeaningContent,
    @Default(true) bool showButton,
    @Default(false) bool includeSelectedVerses,
    String? btnName,
    String? title,
    String? selectFirstVerseTitle,
    String? selectLastVerseTitle,
  }) = _SelectQuranSectionConfig;

  bool get showContentSection => showArabicContent || showMeaningContent;
  bool get showSelectBothVerseNumbers => showSelectFirstVerseNumber && showSelectLastVerseNumber;

}