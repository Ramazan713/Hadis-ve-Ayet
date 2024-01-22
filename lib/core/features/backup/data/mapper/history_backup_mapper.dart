

import 'package:hadith/core/data/local/entities/history_entity.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/history_backup_dto/history_backup_dto.dart';

extension HistoryEntityExt on HistoryEntity{
  HistoryBackupDto toHistoryBackupDto(){
    return HistoryBackupDto(
      id: id,
      name: name,
      modifiedDate: modifiedDate,
      originType: originType
    );
  }
}


extension HistoryBackupDtoExt on HistoryBackupDto{
  HistoryEntity toHistoryEntity(){
    return HistoryEntity(
      id: id,
      name: name,
      modifiedDate: modifiedDate,
      originType: originType
    );
  }
}