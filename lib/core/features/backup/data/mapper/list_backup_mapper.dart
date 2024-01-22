

import 'package:hadith/core/data/local/entities/list/list_entity.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/list_backup_dto/list_backup_dto.dart';

extension ListEntityExt on ListEntity{
  ListBackupDto toListBackupDto(){
    return ListBackupDto(
      id: id,
      name: name,
      pos: pos,
      sourceId: sourceId,
      isRemovable: isRemovable,
      isArchive: isArchive
    );
  }
}


extension ListBackupDtoExt on ListBackupDto{
  ListEntity toListEntity(){
    return ListEntity(
      id: id,
      name: name,
      pos: pos,
      sourceId: sourceId,
      isRemovable: isRemovable,
      isArchive: isArchive
    );
  }
}