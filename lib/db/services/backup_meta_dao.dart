

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/backup_meta.dart';

import '../entities/helper/int_data.dart';

@dao
abstract class BackupMetaDaoOld{

  @Query("""select * from backupMeta where isAuto=0 order by updatedDate desc limit :limit offset :offset""")
  Future<List<BackupMetaOld>>getNonAutoBackupMetaWithOffset(int limit,int offset);

  @Query("""select * from backupMeta where isAuto=1 order by updatedDate desc limit :limit offset :offset""")
  Future<List<BackupMetaOld>>getAutoBackupMetaWithOffset(int limit,int offset);

  @Query("""select count(*) data from backupMeta where isAuto=0""")
  Future<IntData?>getNonAutoBackupMetaSize();

  @Query("""select count(*) data from backupMeta where isAuto=1""")
  Future<IntData?>getAutoBackupMetaSize();

  @Query("""select * from backupMeta where isAuto=1 order by updatedDate limit 1""")
  Future<BackupMetaOld?>getFirstUpdatedAutoBackupMeta();

  @Query("""select * from backupMeta where isAuto=0 order by updatedDate limit 1""")
  Future<BackupMetaOld?>getFirstUpdatedNonAutoBackupMeta();

  @Query("""select * from backupMeta order by updatedDate desc""")
  Stream<List<BackupMetaOld>>getStreamBackupMetas();
  
  @Query("""select * from backupMeta order by updatedDate desc limit 1""")
  Future<BackupMetaOld?>getLastBackupMeta();


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>>insertBackupMetas(List<BackupMetaOld>backupMetas);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int>insertBackupMeta(BackupMetaOld backupMeta);


  @Update()
  Future<int>updateBackupMetas(List<BackupMetaOld>backupMetas);

  @Update()
  Future<int>updateBackupMeta(BackupMetaOld backupMeta);

  @Query("""delete from backupMeta""")
  Future<void>deleteBackupMetaWithQuery();

  @delete
  Future<int>deleteBackupMeta(BackupMetaOld backupMeta);

  @delete
  Future<int>deleteBackupMetas(List<BackupMetaOld>backupMetas);


}