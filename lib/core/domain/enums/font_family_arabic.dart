import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

enum FontFamilyArabicEnum with IPrefEnum{
  scheherazadeNew(
    enumValue: 1,
    fontName: "ScheherazadeNew",
    title: "Scheherazade New"
  ),
  lateef(
    enumValue: 2,
    fontName: "Lateef",
    title: "Lateef"
  ),
  hamattan(
    enumValue: 3,
    fontName: "Harmattan",
    title: "Harmattan"
  );

  const FontFamilyArabicEnum({
    required this.enumValue,
    required this.fontName,
    required this.title
  });

  @override
  final int enumValue;
  final String fontName;
  final String title;

  static FontFamilyArabicEnum get defaultValue => FontFamilyArabicEnum.scheherazadeNew;

  static FontFamilyArabicEnum from(int enumValue){

    if(enumValue == FontFamilyArabicEnum.scheherazadeNew.enumValue){
      return FontFamilyArabicEnum.scheherazadeNew;
    }
    else if(enumValue == FontFamilyArabicEnum.lateef.enumValue){
      return FontFamilyArabicEnum.lateef;
    }
    else if(enumValue == FontFamilyArabicEnum.hamattan.enumValue){
      return FontFamilyArabicEnum.hamattan;
    }
    return FontFamilyArabicEnum.scheherazadeNew;
  }
}