


import 'package:hadith/core/data/local/entities/save_point_entity.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';

extension SavePointEntityExt on SavePointEntity{

  SavePoint toSavePoint(){
    return SavePoint(
        id: id,
        itemIndexPos: itemIndexPos,
        title: title,
        autoType: SaveAutoTypeExt.fromIndex(autoType),
        modifiedDate: modifiedDate,
        destination: SavePointDestination.from(savePointType, parentKey,
            parentName, bookScope),
    );
  }
}


extension SavePointExt on SavePoint{
  SavePointEntity toSavePointEntity(){
    return SavePointEntity(
        id: id,
        itemIndexPos: itemIndexPos,
        title: title,
        autoType: autoType.index,
        modifiedDate: modifiedDate,
        savePointType: destination.getType().typeId,
        bookScope: destination.getBookScope().binaryId,
        parentName: destination.getParentName(),
        parentKey: destination.getParentKey(),
    );
  }
}