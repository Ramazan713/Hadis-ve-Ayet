

import 'package:hadith/constants/enums/book_enum.dart';

enum HadithBookEnum{
  serlevha,
  sitte;
}

extension HadithBookEnumExt on HadithBookEnum{

  int get bookId{
    switch(this){
      case HadithBookEnum.serlevha:
        return BookEnum.serlevha.bookId;
      case HadithBookEnum.sitte:
        return BookEnum.sitte.bookId;
    }
  }

  BookEnum toBookEnum(){
    switch(this){
      case HadithBookEnum.serlevha:
        return BookEnum.serlevha;
      case HadithBookEnum.sitte:
        return BookEnum.sitte;
    }
  }

}