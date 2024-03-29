

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SourceTypeEnum{
  hadith,verse
}

extension SourceTypeEnumExt on SourceTypeEnum{
  int get sourceId{
    switch(this){
      case SourceTypeEnum.hadith:
        return 1;
      case SourceTypeEnum.verse:
        return 2;
    }
  }

  String get shortName{
    switch(this){
      case SourceTypeEnum.hadith:
        return "Hadis";
      case SourceTypeEnum.verse:
        return "Ayet";
    }
  }

  Icon getListIcon(BuildContext context, bool isRemovable){
    if(!isRemovable){
      return Icon(Icons.favorite, size: 30, color: Theme.of(context).colorScheme.error,);
    }
    switch(this){
      case SourceTypeEnum.hadith:
        return const Icon(
            Icons.my_library_books,
            size: 30,
        );
      case SourceTypeEnum.verse:
        return const Icon(
            FontAwesomeIcons.bookQuran,
            size: 30,
        );
    }
  }


  static SourceTypeEnum fromSourceId(sourceId){
    switch(sourceId){
      case 1:
        return SourceTypeEnum.hadith;
      case 2:
        return SourceTypeEnum.verse;
      default:
        return SourceTypeEnum.verse;
    }
  }

}