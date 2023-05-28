

import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

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

  static ListBookScope fromWithDefault(BookScopeEnum scopeEnum){
    return from(scopeEnum) ?? ListBookScope.hadith;
  }

}