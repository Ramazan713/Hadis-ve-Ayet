import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/backup_meta.dart';

abstract class IBackupMetaEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class BackupMetaEventRefresh extends IBackupMetaEvent{}

class BackupMetaEventInit extends IBackupMetaEvent{}


class BackupMetaEventSelectBackupMeta extends IBackupMetaEvent{
  final BackupMeta backupMeta;
  BackupMetaEventSelectBackupMeta({required this.backupMeta});
}

class BackupMetaEventSetCounter extends IBackupMetaEvent{
  final String?counter;
  final bool isDisableRefresh;
  BackupMetaEventSetCounter({required this.counter,this.isDisableRefresh=true});
}






