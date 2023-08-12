

import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

enum ArabicVerseUI3X with IPrefEnum{
  mealArabic(
      enumValue: 1
  ),
  meal(
      enumValue: 2
  ),
  arabic(
      enumValue: 3
  ),
  pronunciation(
      enumValue: 4
  ),
  mealPronunciation(
      enumValue: 5
  ),
  arabicPronunciation(
      enumValue: 6
  ),
  all(
      enumValue: 7
  );

  const ArabicVerseUI3X({required this.enumValue});

  @override
  final int enumValue;


  bool get mealVisible{
    return [ArabicVerseUI3X.mealArabic,ArabicVerseUI3X.meal,ArabicVerseUI3X.all,
      ArabicVerseUI3X.mealPronunciation
    ].contains(this);
  }
  bool get arabicVisible{
    return [ArabicVerseUI3X.arabicPronunciation,ArabicVerseUI3X.arabic,
      ArabicVerseUI3X.all,ArabicVerseUI3X.mealArabic].contains(this);
  }
  bool get pronunciationVisible{
    return [ArabicVerseUI3X.arabicPronunciation,ArabicVerseUI3X.pronunciation,
      ArabicVerseUI3X.all, ArabicVerseUI3X.mealPronunciation
    ].contains(this);
  }

  String get title{
    switch(this){
      case ArabicVerseUI3X.mealArabic:
        return "Arapça ve Meal";
      case ArabicVerseUI3X.meal:
        return "Sadece Meal";
      case ArabicVerseUI3X.arabic:
        return "Sadece Arapça";
      case ArabicVerseUI3X.pronunciation:
        return "Sadece Okunuşu";
      case ArabicVerseUI3X.mealPronunciation:
        return "Meal ve Okunuşu";
      case ArabicVerseUI3X.arabicPronunciation:
        return "Arapça ve Okunuşu";
      case ArabicVerseUI3X.all:
        return "Hepsi";
    }
  }

  static ArabicVerseUI3X get defaultValue => ArabicVerseUI3X.all;

  static ArabicVerseUI3X from(int enumValue){

    if(enumValue == ArabicVerseUI3X.mealArabic.enumValue){
      return ArabicVerseUI3X.mealArabic;
    }
    else if(enumValue == ArabicVerseUI3X.meal.enumValue){
      return ArabicVerseUI3X.meal;
    }
    else if(enumValue == ArabicVerseUI3X.mealPronunciation.enumValue){
      return ArabicVerseUI3X.mealPronunciation;
    }
    else if(enumValue == ArabicVerseUI3X.pronunciation.enumValue){
      return ArabicVerseUI3X.pronunciation;
    }
    else if(enumValue == ArabicVerseUI3X.arabicPronunciation.enumValue){
      return ArabicVerseUI3X.arabicPronunciation;
    }
    else if(enumValue == ArabicVerseUI3X.arabic.enumValue){
      return ArabicVerseUI3X.arabic;
    }
    else if(enumValue == ArabicVerseUI3X.all.enumValue){
      return ArabicVerseUI3X.all;
    }
    return defaultValue;
  }

}

enum ArabicVerseUI3XOption {
  arabic,
  pronunciation,
  meal;


  String get description{
    switch(this){
      case ArabicVerseUI3XOption.arabic:
        return "Arapça göster";
      case ArabicVerseUI3XOption.meal:
        return "Meal göster";
      case ArabicVerseUI3XOption.pronunciation:
        return "Okunuşunu göster";
    }
  }

  static List<ArabicVerseUI3XOption> fromVerseUiEnum(ArabicVerseUI3X verseUi){
    final result = <ArabicVerseUI3XOption>[];
    if(verseUi.arabicVisible){
      result.add(ArabicVerseUI3XOption.arabic);
    }
    if(verseUi.pronunciationVisible){
      result.add(ArabicVerseUI3XOption.pronunciation);
    }
    if(verseUi.mealVisible){
      result.add(ArabicVerseUI3XOption.meal);
    }
    return result;
  }

  static ArabicVerseUI3X toVerseUiEnum(List<ArabicVerseUI3XOption>options){
    final optionLength = options.length;
    if(optionLength == 3) {
      return ArabicVerseUI3X.all;
    }

    if(optionLength == 2){
      if(!options.contains(ArabicVerseUI3XOption.arabic)){
        return ArabicVerseUI3X.mealPronunciation;
      }
      if(!options.contains(ArabicVerseUI3XOption.meal)){
        return ArabicVerseUI3X.arabicPronunciation;
      }
      if(!options.contains(ArabicVerseUI3XOption.pronunciation)){
        return ArabicVerseUI3X.mealArabic;
      }
    }
    if(options.contains(ArabicVerseUI3XOption.arabic)){
      return ArabicVerseUI3X.arabic;
    }
    if(options.contains(ArabicVerseUI3XOption.meal)){
      return ArabicVerseUI3X.meal;
    }
    if(options.contains(ArabicVerseUI3XOption.pronunciation)){
      return ArabicVerseUI3X.pronunciation;
    }
    return ArabicVerseUI3X.all;
  }

}
