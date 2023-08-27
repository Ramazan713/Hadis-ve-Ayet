

import 'package:hadith/core/domain/enums/backup_meta_control_enum.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';

abstract class BackupMetaRepo{

  Stream<List<BackupMetaModel>> getStreamBackupModels();

  Future<void> insertBackupMeta(BackupMetaModel item);

  Future<void> insertBackupMetas(List<BackupMetaModel> items);

  Future<void> updateBackupMeta(BackupMetaModel updatedItem);

  Future<void> replaceBackupMetas(List<BackupMetaModel> items);

  Future<void> deleteAllBackupMetas();

  Future<void> deleteBackupMetas(List<BackupMetaModel> items);

  Future<BackupMetaModel?> getLastBackupMeta();

  Future<BackupMetaModel?> getFirstBackupMeta(bool isAuto);

  Future<List<BackupMetaModel>> getRedundantBackupMetas({
    required bool isAuto,
    required int keepTopNItem
  });

  Future<BackupMetaControlEnum> getControlEnum({
    required bool isAuto,
    required int keepTopNItem
  });
}