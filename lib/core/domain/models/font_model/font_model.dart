

import 'package:equatable/equatable.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/enums/font_size/font_size.dart';
part 'font_model.freezed.dart';

@freezed
class FontModel with _$FontModel{
  const FontModel._();

  const factory FontModel({
    required FontFamilyArabicEnum arabicFontFamilyEnum,
    required FontSizeEnum contentFontSizeEnum,
    required FontSizeEnum arabicFontSizeEnum
  }) = _FontModel;

  double get contentFontSize => contentFontSizeEnum.size;
  double get arabicFontSize => arabicFontSizeEnum.size;
  String get arabicFontFamily => arabicFontFamilyEnum.fontName;

  static FontModel init(){
    return FontModel(
      contentFontSizeEnum: KPref.fontSizeContent.defaultPrefEnum,
      arabicFontSizeEnum: KPref.fontSizeArabic.defaultPrefEnum,
      arabicFontFamilyEnum: KPref.fontFamilyArabic.defaultPrefEnum
    );
  }
}