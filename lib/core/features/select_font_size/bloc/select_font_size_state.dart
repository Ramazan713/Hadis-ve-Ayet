
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/font_family_arabic.dart';

class SelectFontSizeState extends Equatable{

  final double contentFontSize;
  final double arabicFontSize;
  final FontFamilyArabicEnum fontFamilyArabic;
  final String? message;

  const SelectFontSizeState({
    required this.fontFamilyArabic,
    required this.arabicFontSize,
    required this.contentFontSize,
    this.message
  });

  SelectFontSizeState copyWith({
    double? contentFontSize,
    double? arabicFontSize,
    FontFamilyArabicEnum? fontFamilyArabic,
    String? message, bool setMessage = false
  }) {
    return SelectFontSizeState(
        contentFontSize: contentFontSize ?? this.contentFontSize,
        arabicFontSize: arabicFontSize ?? this.arabicFontSize,
        fontFamilyArabic: fontFamilyArabic ?? this.fontFamilyArabic,
        message: setMessage ? message : this.message
    );
  }

  static SelectFontSizeState init(){
    return SelectFontSizeState(
        contentFontSize: KPref.fontSizeContent.defaultValue,
        arabicFontSize: KPref.fontSizeArabic.defaultValue,
        fontFamilyArabic: KPref.fontFamilyArabic.defaultPrefEnum
    );
  }

  @override
  List<Object?> get props => [contentFontSize, arabicFontSize, fontFamilyArabic, message];

}