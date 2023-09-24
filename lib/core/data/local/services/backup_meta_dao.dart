

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/backup_meta.dart';

@dao
abstract class BackupMetaDao{

  @Query("""select * from backupMetas where isAuto = :isAuto order by updatedDate desc limit :limit offset :offset""")
  Future<List<BackupMetaEntity>> getBackupMetaWithAutoAndOffset(bool isAuto,int limit, int offset);

  @Query("""select * from backupMetas order by updatedDate desc""")
  Stream<List<BackupMetaEntity>> getStreamBackupMetas();

  @Query("""select * from backupMetas order by updatedDate desc""")
  Future<List<BackupMetaEntity>> getBackupMetas();

  @Query("""select * from backupMetas order by updatedDate desc limit 1""")
  Future<BackupMetaEntity?> getLastBackupMeta();

  @Query("""select * from backupMetas where isAuto = :isAuto order by updatedDate limit 1""")
  Future<BackupMetaEntity?> getFirstBackupMeta(bool isAuto);

  @Query("""select count(*) data from backupMetas where isAuto = :isAuto""")
  Future<int?> getBackupMetaSizeWithAuto(bool isAuto);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBackupMetas(List<BackupMetaEntity>backupMetas);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBackupMeta(BackupMetaEntity backupMeta);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBackupMeta(BackupMetaEntity backupMeta);

  @delete
  Future<void> deleteBackupMetas(List<BackupMetaEntity>backupMetas);
}