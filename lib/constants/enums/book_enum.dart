
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

enum BookEnum{
  serlevha,
  sitte,
  diyanetMeal,
  none
}

extension BookIdsExtension on BookEnum{

  int get bookId{
    switch(this){
      case BookEnum.none:
        return 0;
      case BookEnum.serlevha:
        return 1;
      case BookEnum.sitte:
        return 2;
      case BookEnum.diyanetMeal:
        return 3;
    }
  }

  BookScopeEnum? get bookScope{
    switch(this){
      case BookEnum.none:
        return null;
      case BookEnum.serlevha:
        return BookScopeEnum.serlevha;
      case BookEnum.sitte:
        return BookScopeEnum.sitte;
      case BookEnum.diyanetMeal:
        return BookScopeEnum.diyanetMeal;
    }
  }

}
