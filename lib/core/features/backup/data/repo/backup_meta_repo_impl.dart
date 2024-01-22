

import 'package:hadith/core/data/local/services/backup_meta_dao.dart';
import 'package:hadith/core/features/backup/data/mapper/backup_meta_mapper.dart';
import 'package:hadith/core/features/backup/domain/enums/backup_meta_control_enum.dart';
import 'package:hadith/core/features/backup/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/core/features/backup/domain/repo/backup_meta_repo.dart';

class BackupMetaRepoImpl extends BackupMetaRepo{
  late final BackupMetaDao _backupMetaDao;

  BackupMetaRepoImpl({
    required BackupMetaDao backupMetaDao
  }){
    _backupMetaDao = backupMetaDao;
  }

  @override
  Stream<List<BackupMetaModel>> getStreamBackupModels(){
    return _backupMetaDao.getStreamBackupMetas()
        .map((items) => items.map((e) => e.toBackupMeta()).toList());
  }

  @override
  Future<void> insertBackupMetas(List<BackupMetaModel> items) async{
    final newEntities = items.map((e) => e.toBackupMetaEntity()).toList();
    await _backupMetaDao.insertBackupMetas(newEntities);
  }

  @override
  Future<void> insertBackupMeta(BackupMetaModel item)async{
    await _backupMetaDao.insertBackupMeta(item.toBackupMetaEntity());
  }

  @override
  Future<void> updateBackupMeta(BackupMetaModel updatedItem)async{
    await _backupMetaDao.updateBackupMeta(updatedItem.toBackupMetaEntity());
  }

  @override
  Future<void> replaceBackupMetas(List<BackupMetaModel> items)async{
    await deleteAllBackupMetas();
    await insertBackupMetas(items);
  }

  @override
  Future<void> deleteAllBackupMetas()async{
    final oldEntities = await _backupMetaDao.getBackupMetas();
    await _backupMetaDao.deleteBackupMetas(oldEntities);
  }

  @override
  Future<void> deleteBackupMetas(List<BackupMetaModel> items)async{
    final oldEntities = items.map((e) => e.toBackupMetaEntity()).toList();
    await _backupMetaDao.deleteBackupMetas(oldEntities);
  }

  @override
  Future<BackupMetaModel?> getLastBackupMeta()async{
    return (await _backupMetaDao.getLastBackupMeta())?.toBackupMeta();
  }

  @override
  Future<List<BackupMetaModel>> getRedundantBackupMetas({
    required bool isAuto,
    required int keepTopNItem
  }) async{
    if(keepTopNItem < 1) return [];

    final itemsLen = (await _backupMetaDao.getBackupMetaSizeWithAuto(isAuto)) ?? 0;
    if(keepTopNItem >= itemsLen) return [];

    final limit = itemsLen - keepTopNItem;
    final entities = await _backupMetaDao.getBackupMetaWithAutoAndOffset(isAuto, limit, keepTopNItem);

    return entities.map((e) => e.toBackupMeta()).toList();
  }

  @override
  Future<BackupMetaControlEnum> getControlEnum({
    required bool isAuto,
    required int keepTopNItem
  })async{
    final itemsLen = (await _backupMetaDao.getBackupMetaSizeWithAuto(isAuto)) ?? 0;

    if(keepTopNItem == 0) return BackupMetaControlEnum.none;

    if(itemsLen == keepTopNItem) return BackupMetaControlEnum.fixed;

    if(itemsLen <= keepTopNItem) return BackupMetaControlEnum.insert;

    if(itemsLen > keepTopNItem) return BackupMetaControlEnum.delete;

    return BackupMetaControlEnum.none;
  }

  @override
  Future<BackupMetaModel?> getFirstBackupMeta(bool isAuto) async{
    return (await _backupMetaDao.getFirstBackupMeta(isAuto))?.toBackupMeta();
  }
}