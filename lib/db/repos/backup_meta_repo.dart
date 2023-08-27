

import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/backup_meta_control.dart';
import 'package:hadith/db/services/backup_meta_dao.dart';

import '../entities/backup_meta.dart';
import '../entities/helper/int_data.dart';

class BackupMetaRepoOld{
  final BackupMetaDaoOld backupMetaDao;
  BackupMetaRepoOld({required this.backupMetaDao});


  Future<BackupMetaControl>controlNonAutoBackups()async{
    final countData=await backupMetaDao.getNonAutoBackupMetaSize();
    if(countData!=null){
      final size=countData.data;
      if(kNonAutoMaxBackups==0){
        return BackupMetaControl.none;
      }else if(size==kNonAutoMaxBackups){
        return BackupMetaControl.fixed;
      }else if(size<=kNonAutoMaxBackups){
        return BackupMetaControl.insert;
      }else{
        return BackupMetaControl.delete;
      }
    }
    return BackupMetaControl.none;
  }

  Future<BackupMetaControl>controlAutoBackups()async{
    final countData=await backupMetaDao.getAutoBackupMetaSize();
    if(countData!=null){
      final size=countData.data;
      if(kAutoMaxBackups==0){
        return BackupMetaControl.none;
      }else if(size==kAutoMaxBackups){
        return BackupMetaControl.fixed;
      }else if(size<=kAutoMaxBackups){
        return BackupMetaControl.insert;
      }else{
        return BackupMetaControl.delete;
      }
    }
    return BackupMetaControl.none;
  }

  Future<BackupMetaOld?>getLastBackupMeta()=>backupMetaDao.getLastBackupMeta();

  Future<List<BackupMetaOld>>getNonAutoBackupMetaWithOffset(int limit,int offset)=>
      backupMetaDao.getNonAutoBackupMetaWithOffset(limit,offset);

  Future<List<BackupMetaOld>>getAutoBackupMetaWithOffset(int limit,int offset)=>
      backupMetaDao.getAutoBackupMetaWithOffset(limit,offset);

  Future<IntData?>getNonAutoBackupMetaSize()=>backupMetaDao.getNonAutoBackupMetaSize();

  Future<IntData?>getAutoBackupMetaSize()=>backupMetaDao.getAutoBackupMetaSize();

  Future<BackupMetaOld?>getFirstUpdatedAutoBackupMeta()=>
      backupMetaDao.getFirstUpdatedAutoBackupMeta();

  Future<BackupMetaOld?>getFirstUpdatedNonAutoBackupMeta()=>
      backupMetaDao.getFirstUpdatedNonAutoBackupMeta();

  Stream<List<BackupMetaOld>>getStreamBackupMetas()=>backupMetaDao.getStreamBackupMetas();

  Future<List<int>>insertBackupMetas(List<BackupMetaOld>backupMetas)=>
      backupMetaDao.insertBackupMetas(backupMetas);

  Future<int>insertBackupMeta(BackupMetaOld backupMeta)=>backupMetaDao.insertBackupMeta(backupMeta);

  Future<int>updateBackupMetas(List<BackupMetaOld>backupMetas)=>
      backupMetaDao.updateBackupMetas(backupMetas);

  Future<int>updateBackupMeta(BackupMetaOld backupMeta)=>backupMetaDao.updateBackupMeta(backupMeta);

  Future<int>deleteBackupMeta(BackupMetaOld backupMeta)=>backupMetaDao.deleteBackupMeta(backupMeta);

  Future<int>deleteBackupMetas(List<BackupMetaOld>backupMetas)=>
      backupMetaDao.deleteBackupMetas(backupMetas);

  Future<void>deleteBackupMetaWithQuery()=>backupMetaDao.deleteBackupMetaWithQuery();

}