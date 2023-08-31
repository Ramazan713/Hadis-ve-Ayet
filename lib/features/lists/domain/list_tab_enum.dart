

import 'package:hadith/core/domain/enums/source_type_enum.dart';

enum ListTabEnum{
  hadith,verse
}

extension ListTabEnumExt on ListTabEnum{

  SourceTypeEnum get sourceType{
    switch(this){
      case ListTabEnum.hadith:
        return SourceTypeEnum.hadith;
      case ListTabEnum.verse:
        return SourceTypeEnum.verse;
    }
  }

  int get index{
    switch(this){
      case ListTabEnum.hadith:
        return 0;
      case ListTabEnum.verse:
        return 1;
    }
  }

  static ListTabEnum get defaultTab{
    return ListTabEnum.hadith;
  }

  static ListTabEnum fromIndex(int index){
    switch(index){
      case 0:
        return ListTabEnum.hadith;
      case 1:
        return ListTabEnum.verse;
      default:
        return defaultTab;
    }
    return ListTabEnum.hadith;
  }
}
