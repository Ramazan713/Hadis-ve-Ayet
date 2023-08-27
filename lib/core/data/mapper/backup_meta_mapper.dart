

import 'package:hadith/core/data/local/entities/backup_meta.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';

extension BackupMetaEntityExt on BackupMetaEntity{

  BackupMetaModel toBackupMeta(){
    return BackupMetaModel(
      id: id,
      fileName: fileName,
      updatedDate: updatedDate,
      isAuto: isAuto
    );
  }
}

extension BackupMetaModelExt on BackupMetaModel{

  BackupMetaEntity toBackupMetaEntity(){
    return BackupMetaEntity(
        id: id,
        fileName: fileName,
        updatedDate: updatedDate,
        isAuto: isAuto
    );
  }
}