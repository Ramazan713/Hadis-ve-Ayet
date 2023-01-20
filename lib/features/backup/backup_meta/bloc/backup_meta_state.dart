import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/db/entities/backup_meta.dart';

class BackupMetaState extends Equatable{

  final DataStatus status;
  final List<BackupMeta>backupMetas;
  final bool isDisableRefresh;
  final String counter;
  final BackupMeta? selectedBackup;
  final String?message;

  const BackupMetaState({required this.status,required this.backupMetas,required this.isDisableRefresh,
    this.counter="",this.selectedBackup,this.message});

  BackupMetaState copyWith({DataStatus? status,List<BackupMeta>?backupMetas,bool? isDisableRefresh,
    String? counter,BackupMeta? selectedBackup,bool setBackupMeta=false,String?message,
    bool setMessage=false
  }){
    return BackupMetaState(
        status: status??this.status,
        backupMetas: backupMetas??this.backupMetas,
        isDisableRefresh: isDisableRefresh??this.isDisableRefresh,
        counter: counter??this.counter,
        selectedBackup: setBackupMeta?selectedBackup:this.selectedBackup,
        message: setMessage ? message : this.message
    );
  }

  static BackupMetaState init(){
    return const BackupMetaState(
        status: DataStatus.initial,
        backupMetas: [],
        isDisableRefresh: false,
    );
  }

  @override
  List<Object?> get props => [status,backupMetas,isDisableRefresh,counter,selectedBackup,message];
}