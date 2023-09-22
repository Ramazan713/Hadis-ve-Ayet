

import 'package:hadith/core/domain/enums/book_enum.dart';

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


  static HadithBookEnum from(int hadithBookId){
    if(hadithBookId == BookEnum.serlevha.bookId) {
      return HadithBookEnum.serlevha;
    }

    if(hadithBookId == BookEnum.sitte.bookId) {
      return HadithBookEnum.sitte;
    }
    return HadithBookEnum.serlevha;
  }

}