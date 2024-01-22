


import 'package:hadith/core/data/local/entities/list/list_hadith_entity.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/list_hadith_backup_dto/list_hadith_backup_dto.dart';

extension ListHadithEntityExt on ListHadithEntity{
  ListHadithBackupDto toListHadithBackupDto(){
    return ListHadithBackupDto(
      pos: pos,
      hadithId: hadithId,
      listId: listId
    );
  }
}


extension ListHadithBackupDtoExt on ListHadithBackupDto{
  ListHadithEntity toListHadithEntity(){
    return ListHadithEntity(
      pos: pos,
      hadithId: hadithId,
      listId: listId
    );
  }
}