
abstract class IBackupEvent{}

class BackupEventDeleteAllUserData extends IBackupEvent{}

class BackupEventDownloadLastBackup extends IBackupEvent{}

class BackupEventUploadBackup extends IBackupEvent{
  final bool isAuto;
  final String? actionKey;
  BackupEventUploadBackup({
    required this.isAuto,
    this.actionKey
  });
}

class BackupEventDownloadFile extends IBackupEvent{
  final String fileName;
  final bool deleteAllLocalData;
  BackupEventDownloadFile({required this.fileName,required this.deleteAllLocalData});
}


class BackupEventClearCompletedLoading extends IBackupEvent{}

class BackupEventClearRefreshApp extends IBackupEvent{}

class BackupEventClearMessage extends IBackupEvent{}

class BackupEventClearActionResult extends IBackupEvent{}

