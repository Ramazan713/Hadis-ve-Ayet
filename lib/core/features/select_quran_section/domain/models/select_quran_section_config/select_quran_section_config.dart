

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'select_quran_section_config.freezed.dart';

@freezed
class SelectQuranSectionConfig with _$SelectQuranSectionConfig{

  const SelectQuranSectionConfig._();

  const factory SelectQuranSectionConfig({
    @Default(false) bool showAutoName,
    @Default(false) bool showSelectJuz,
    @Default(false) bool showSelectSurah,
    @Default(false) bool showSelectPage,
    @Default(false) bool showSelectFirstVerseNumber,
    @Default(false) bool showSelectLastVerseNumber,
    @Default(false) bool showArabicContent,
    @Default(false) bool showMeaningContent,
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