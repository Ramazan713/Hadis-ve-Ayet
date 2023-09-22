

import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';

enum BookScopeEnum{
  serlevha,
  sitte,
  diyanetMeal,
  serlevhaSitte
}

extension BookScopeExt on BookScopeEnum{
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

  static BookScopeEnum fromBinaryId(int binaryId){
    switch(binaryId){
      case 1:
        return BookScopeEnum.serlevha;
      case 2:
        return BookScopeEnum.sitte;
      case 3:
        return BookScopeEnum.serlevhaSitte;
      case 4:
        return BookScopeEnum.diyanetMeal;
      default:
        return BookScopeEnum.serlevha;

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
        return BookEnum.serlevha.title;
      case BookScopeEnum.sitte:
        return BookEnum.sitte.title;
      case BookScopeEnum.serlevhaSitte:
        return "Hadisler";
      case BookScopeEnum.diyanetMeal:
        return BookEnum.diyanetMeal.title;
    }
  }


}
