

enum ArabicVerseUI2X{
  both,onlyMeal,onlyArabic
}

extension ArabicVerseUI2XExt on ArabicVerseUI2X{
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

  bool get arabicVisible{
    return [ArabicVerseUI2X.onlyArabic,ArabicVerseUI2X.both].contains(this);
  }
  bool get mealVisible{
    return [ArabicVerseUI2X.onlyMeal,ArabicVerseUI2X.both].contains(this);
  }
}