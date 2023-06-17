

import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

enum ArabicVerseUI2X with IPrefEnum{
  both(
    enumValue: 0
  ),
  onlyMeal(
    enumValue: 1
  ),
  onlyArabic(
    enumValue: 2
  );

  const ArabicVerseUI2X({required this.enumValue});

  @override
  final int enumValue;

  bool get arabicVisible{
    return [ArabicVerseUI2X.onlyArabic,ArabicVerseUI2X.both].contains(this);
  }
  bool get mealVisible{
    return [ArabicVerseUI2X.onlyMeal,ArabicVerseUI2X.both].contains(this);
  }

  String get description{
    switch(this){
      case ArabicVerseUI2X.onlyArabic:
        return "Sadece arapça göster";
      case ArabicVerseUI2X.onlyMeal:
        return "Sadece meal göster";
      case ArabicVerseUI2X.both:
        return "Arapça ve meal göster";
    }
  }

  static ArabicVerseUI2X get defaultValue => ArabicVerseUI2X.both;


  static ArabicVerseUI2X from(int enumValue){

    if(enumValue == ArabicVerseUI2X.both.enumValue){
      return ArabicVerseUI2X.both;
    }
    else if(enumValue == ArabicVerseUI2X.onlyMeal.enumValue){
      return ArabicVerseUI2X.onlyMeal;
    }
    else if(enumValue == ArabicVerseUI2X.onlyArabic.enumValue){
      return ArabicVerseUI2X.onlyArabic;
    }
    return defaultValue;
  }

}
