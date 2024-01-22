import 'package:hadith/core/data/local/entities/save_point_entity.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';


extension SavePointEntityExt on SavePointEntity{

  SavePoint toSavePoint(){
    return SavePoint(
        id: id,
        itemPos: itemIndexPos,
        title: title,
        autoType: SaveAutoTypeExt.fromIndex(autoType),
        modifiedDate: modifiedDate,
        destination: SavePointDestination.from(savePointType, parentKey, parentName, bookScope),
    );
  }
}


extension SavePointExt on SavePoint{
  SavePointEntity toSavePointEntity(){
    return SavePointEntity(
        id: id,
        itemIndexPos: itemPos,
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