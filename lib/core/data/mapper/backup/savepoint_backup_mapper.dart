


import 'package:hadith/core/data/local/entities/save_point_entity.dart';
import 'package:hadith/core/data/remote/backup_dtos/savepoint_backup_dto/savepoint_backup_dto.dart';

extension SavePointEntityExt on SavePointEntity{
  SavePointBackupDto toSavePointBackupDto(){
    return SavePointBackupDto(
      id: id,
      title: title,
      modifiedDate: modifiedDate,
      autoType: autoType,
      bookScope: bookScope,
      itemIndexPos: itemIndexPos,
      parentKey: parentKey,
      parentName: parentName,
      savePointType: savePointType
    );
  }
}


extension SavePointBackupDtoExt on SavePointBackupDto{
  SavePointEntity toSavePointEntity(){
    return SavePointEntity(
      id: id,
      title: title,
      modifiedDate: modifiedDate,
      autoType: autoType,
      bookScope: bookScope,
      itemIndexPos: itemIndexPos,
      parentKey: parentKey,
      parentName: parentName,
      savePointType: savePointType
    );
  }
}