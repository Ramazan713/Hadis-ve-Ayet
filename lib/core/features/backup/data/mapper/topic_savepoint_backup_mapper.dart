


import 'package:hadith/core/data/local/entities/topic_savepoint_entity.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/topic_savepoint_backup_dto/topic_savepoint_backup_dto.dart';

extension TopicSavePointEntityExt on TopicSavePointEntity{
  TopicSavePointBackupDto toTopicSavePointBackupDto(){
    return TopicSavePointBackupDto(
      id: id,
      parentKey: parentKey,
      pos: pos,
      type: type
    );
  }
}


extension TopicSavePointBackupDtoExt on TopicSavePointBackupDto{
  TopicSavePointEntity toTopicSavePointEntity(){
    return TopicSavePointEntity(
      id: id,
      parentKey: parentKey,
      pos: pos,
      type: type
    );
  }
}