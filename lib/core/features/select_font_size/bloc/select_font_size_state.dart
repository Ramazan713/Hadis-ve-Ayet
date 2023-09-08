
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/enums/font_size/font_size.dart';
part 'select_font_size_state.freezed.dart';

@freezed
class SelectFontSizeState with _$SelectFontSizeState{

  const SelectFontSizeState._();

  const factory SelectFontSizeState({
    required FontSizeEnum selectedContentFontSize,
    required FontSizeEnum lastSavedContentFontSize,
    required FontSizeEnum selectedArabicFontSize,
    required FontSizeEnum lastSavedArabicFontSize,
    required FontFamilyArabicEnum selectedFontFamilyArabic,
    required FontFamilyArabicEnum lastSavedSelectedFontFamilyArabic,
    String? message
  }) = _SelectFontSizeState;

  static SelectFontSizeState init(){
    return SelectFontSizeState(
      lastSavedArabicFontSize: KPref.fontSizeArabic.defaultPrefEnum,
      selectedArabicFontSize: KPref.fontSizeArabic.defaultPrefEnum,
      lastSavedContentFontSize: KPref.fontSizeContent.defaultPrefEnum,
      selectedContentFontSize: KPref.fontSizeContent.defaultPrefEnum,
      lastSavedSelectedFontFamilyArabic: KPref.fontFamilyArabic.defaultPrefEnum,
      selectedFontFamilyArabic: KPref.fontFamilyArabic.defaultPrefEnum,
    );
  }


  bool get contentSizeChanged => selectedContentFontSize != lastSavedContentFontSize;

  bool get arabicSizeChanged => lastSavedArabicFontSize != selectedArabicFontSize;

  bool get arabicFamilyChanged => lastSavedSelectedFontFamilyArabic != selectedFontFamilyArabic;

  bool get anyChanged => contentSizeChanged || arabicSizeChanged || arabicFamilyChanged;

  bool get saveButtonEnabled => anyChanged;

  bool get resetButtonEnabled => anyChanged;
}
