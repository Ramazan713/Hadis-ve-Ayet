

import 'package:hadith/constants/enums/sourcetype_enum.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

class SourceTypeHelper{

  static SourceTypeEnum getSourceTypeWithSourceId(int sourceId){
    if(SourceTypeEnum.verse.sourceId == sourceId){
      return SourceTypeEnum.verse;
    }
    return SourceTypeEnum.hadith;
  }

  static BookScopeEnum getBookScopeFromBookBinaryId(int bookBinaryId){
    return BookScopeEnum.values.firstWhere((element) => element.binaryId == bookBinaryId);
  }

}