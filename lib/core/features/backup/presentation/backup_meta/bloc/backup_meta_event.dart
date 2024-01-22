
import 'package:hadith/core/features/backup/domain/models/backup_meta_model/backup_meta_model.dart';

abstract class IBackupMetaEvent{}

class BackupMetaEventRefresh extends IBackupMetaEvent{}

class BackupMetaEventListenData extends IBackupMetaEvent{}

class BackupMetaEventLoadData extends IBackupMetaEvent{}

class BackupMetaEventSelectBackupMeta extends IBackupMetaEvent{
  final BackupMetaModel backupMeta;
  BackupMetaEventSelectBackupMeta({required this.backupMeta});
}

class BackupMetaEventSetCounter extends IBackupMetaEvent{
  final String? counter;
  final bool isDisableRefresh;
  BackupMetaEventSetCounter({required this.counter,this.isDisableRefresh=true});
}

class BackupMetaEventClearMessage extends IBackupMetaEvent{}






