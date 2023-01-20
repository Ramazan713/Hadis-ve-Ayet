


import 'package:floor/floor.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

class BookScopeConverter extends TypeConverter<BookScopeEnum,int>{
  @override
  BookScopeEnum decode(int databaseValue) {
    var scope = BookScopeEnum.serlevha;
    for(final bookScope in BookScopeEnum.values){
      if(bookScope.binaryId == databaseValue){
        scope=bookScope;
      }
    }
    return scope;
  }

  @override
  int encode(BookScopeEnum value) {
    return value.binaryId;
  }

}