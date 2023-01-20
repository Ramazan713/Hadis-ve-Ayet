

import 'package:floor/floor.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';

class SaveAutoTypeConverter extends TypeConverter<SaveAutoType,int>{
  @override
  SaveAutoType decode(int databaseValue) {
    var autoType=SaveAutoType.none;

    for(final type in SaveAutoType.values){
      if(type.index == databaseValue){
        autoType = type;
      }
    }
    return autoType;
  }

  @override
  int encode(SaveAutoType value) {
    return value.index;
  }


}