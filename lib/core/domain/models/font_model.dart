

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/font_family_arabic.dart';

class FontModel extends Equatable{
  final double contentFontSize;
  final double arabicFontSize;
  final FontFamilyArabicEnum arabicFontFamilyEnum;

  const FontModel({required this.contentFontSize,required this.arabicFontSize, required this.arabicFontFamilyEnum});

  static FontModel init(){
    return FontModel(
        contentFontSize: KPref.fontSizeContent.defaultValue,
        arabicFontSize: KPref.fontSizeArabic.defaultValue,
        arabicFontFamilyEnum: KPref.fontFamilyArabic.defaultPrefEnum
    );
  }

  String get arabicFontFamily => arabicFontFamilyEnum.fontName;


  FontModel copyWith({
    double? contentFontSize,
    double? arabicFontSize,
    FontFamilyArabicEnum? arabicFontFamilyEnum
  }){
    return FontModel(
        contentFontSize: contentFontSize ?? this.contentFontSize,
        arabicFontSize: arabicFontSize ?? this.arabicFontSize,
        arabicFontFamilyEnum: arabicFontFamilyEnum ?? this.arabicFontFamilyEnum
    );
  }

  @override
  List<Object?> get props => [contentFontSize, arabicFontSize, arabicFontFamilyEnum];
}