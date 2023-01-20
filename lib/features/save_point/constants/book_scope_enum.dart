

import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/constants/enums/sourcetype_enum.dart';

enum BookScopeEnum{
  serlevha,
  sitte,
  diyanetMeal,
  serlevhaSitte
}

extension ScopeExtension on BookScopeEnum{
  int get binaryId{
    switch(this){
      case BookScopeEnum.serlevha:
        return 1;
      case BookScopeEnum.sitte:
        return 2;
      case BookScopeEnum.serlevhaSitte:
        return 3;
      case BookScopeEnum.diyanetMeal:
        return 4;
    }
  }

  SourceTypeEnum get sourceType{
    switch(this){
      case BookScopeEnum.serlevha:
        return SourceTypeEnum.hadith;
      case BookScopeEnum.sitte:
        return SourceTypeEnum.hadith;
      case BookScopeEnum.serlevhaSitte:
        return SourceTypeEnum.hadith;
      case BookScopeEnum.diyanetMeal:
        return SourceTypeEnum.verse;
    }
  }

  BookEnum? get book{
    switch(this){
      case BookScopeEnum.serlevha:
        return BookEnum.serlevha;
      case BookScopeEnum.sitte:
        return BookEnum.sitte;
      case BookScopeEnum.serlevhaSitte:
        return null;
      case BookScopeEnum.diyanetMeal:
        return BookEnum.diyanetMeal;
    }
  }

  String get description{
    switch(this){
      case BookScopeEnum.serlevha:
        return "Serlevha";
      case BookScopeEnum.sitte:
        return "Kütübi Sitte";
      case BookScopeEnum.serlevhaSitte:
        return "Hadisler";
      case BookScopeEnum.diyanetMeal:
        return "Kur'an";
    }
  }


}
