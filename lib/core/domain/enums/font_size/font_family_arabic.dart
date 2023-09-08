import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

enum FontFamilyArabicEnum with IPrefEnum, IMenuItem{
  scheherazadeNew(
    enumValue: 1,
    fontName: "ScheherazadeNew",
    title: "Scheherazade New",
    textScaleFactor: 1.5
  ),
  lateef(
    enumValue: 2,
    fontName: "Lateef",
    title: "Lateef",
    textScaleFactor: 2.1
  ),
  hamattan(
    enumValue: 3,
    fontName: "Harmattan",
    title: "Harmattan",
    textScaleFactor: 1.65
  );

  const FontFamilyArabicEnum({
    required this.enumValue,
    required this.fontName,
    required this.title,
    required this.textScaleFactor
  });

  @override
  final int enumValue;
  final String fontName;
  final double textScaleFactor;

  @override
  final String title;

  @override
  get iconInfo => null;

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