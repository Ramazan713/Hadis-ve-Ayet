

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';

enum ListBookScope{
  hadith,verse;
}

extension ListBookScopeExt on ListBookScope{

  int get binaryId{
    switch(this){
      case ListBookScope.hadith:
        return BookScopeEnum.serlevhaSitte.binaryId;
      case ListBookScope.verse:
        return BookScopeEnum.diyanetMeal.binaryId;
    }
  }

  BookScopeEnum get bookScopeEnum{
    switch(this){
      case ListBookScope.hadith:
        return BookScopeEnum.serlevhaSitte;
      case ListBookScope.verse:
        return BookScopeEnum.diyanetMeal;
    }
  }

  static ListBookScope? from(BookScopeEnum scopeEnum){
    switch(scopeEnum){
      case BookScopeEnum.serlevhaSitte:
        return ListBookScope.hadith;
      case BookScopeEnum.diyanetMeal:
        return ListBookScope.verse;
      default:
        return null;
    }
  }

  static ListBookScope fromSourceType(SourceTypeEnum sourceType){
    switch(sourceType){
      case SourceTypeEnum.hadith:
        return ListBookScope.hadith;
      case SourceTypeEnum.verse:
        return ListBookScope.verse;
    }
  }

  static ListBookScope fromWithDefault(BookScopeEnum scopeEnum){
    return from(scopeEnum) ?? ListBookScope.hadith;
  }

}