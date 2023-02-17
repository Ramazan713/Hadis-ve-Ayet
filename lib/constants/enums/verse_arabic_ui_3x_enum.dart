

enum ArabicVerseUI3X{
  mealArabic,meal,arabic,pronunciation,mealPronunciation,arabicPronunciation,all
}

enum ArabicVerseOption3XEnum{
  arabic,pronunciation,meal
}

extension ArabicVerseUi3XExt on ArabicVerseUI3X{
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
}


extension ArabicVerseOptionExt on ArabicVerseOption3XEnum{
  String get description{
    switch(this){
      case ArabicVerseOption3XEnum.arabic:
        return "Arapça göster";
      case ArabicVerseOption3XEnum.meal:
        return "Meal göster";
      case ArabicVerseOption3XEnum.pronunciation:
        return "Okunuşunu göster";
    }
  }

  static List<ArabicVerseOption3XEnum> fromVerseUiEnum(ArabicVerseUI3X verseUi){
    final result = <ArabicVerseOption3XEnum>[];
    if(verseUi.arabicVisible){
      result.add(ArabicVerseOption3XEnum.arabic);
    }
    if(verseUi.pronunciationVisible){
      result.add(ArabicVerseOption3XEnum.pronunciation);
    }
    if(verseUi.mealVisible){
      result.add(ArabicVerseOption3XEnum.meal);
    }
    return result;
  }

  static ArabicVerseUI3X toVerseUiEnum(List<ArabicVerseOption3XEnum>options){
    final optionLength = options.length;
    if(optionLength == 3) {
      return ArabicVerseUI3X.all;
    }

    if(optionLength == 2){
      if(!options.contains(ArabicVerseOption3XEnum.arabic)){
        return ArabicVerseUI3X.mealPronunciation;
      }
      if(!options.contains(ArabicVerseOption3XEnum.meal)){
        return ArabicVerseUI3X.arabicPronunciation;
      }
      if(!options.contains(ArabicVerseOption3XEnum.pronunciation)){
        return ArabicVerseUI3X.mealArabic;
      }
    }
    if(options.contains(ArabicVerseOption3XEnum.arabic)){
      return ArabicVerseUI3X.arabic;
    }
    if(options.contains(ArabicVerseOption3XEnum.meal)){
      return ArabicVerseUI3X.meal;
    }
    if(options.contains(ArabicVerseOption3XEnum.pronunciation)){
      return ArabicVerseUI3X.pronunciation;
    }
    return ArabicVerseUI3X.all;
  }

}
