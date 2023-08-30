


import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/domain/manager/backup_manager.dart';
import 'package:hadith/core/domain/models/action_result/action_result.dart';
import 'package:hadith/core/domain/services/auth_service.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';

import 'backup_event.dart';
import 'backup_state.dart';

class BackupBloc extends Bloc<IBackupEvent,BackupState>{

  late final AuthService _authService;
  late final BackupManager _backupManager;
  late final ConnectivityService _connectivityService;

  BackupBloc({
    required AuthService authService,
    required BackupManager backupManager,
    required ConnectivityService connectivityService
  }): super(BackupState.init()){


    _authService = authService;
    _backupManager = backupManager;
    _connectivityService = connectivityService;

    on<BackupEventDownloadLastBackup>(_onDownloadLastBackup,transformer: restartable());
    on<BackupEventDeleteAllUserData>(_onDeleteAllUserData,transformer: restartable());
    on<BackupEventUploadBackup>(_onUploadBackup,transformer: restartable());
    on<BackupEventDownloadFile>(_onDownloadFile,transformer: restartable());

    on<BackupEventClearRefreshApp>(_onClearRefreshApp,transformer: restartable());
    on<BackupEventClearCompletedLoading>(_onClearCompletedLoading,transformer: restartable());
    on<BackupEventClearMessage>(_onClearMessage,transformer: restartable());
    on<BackupEventClearActionResult>(_onClearActionResult,transformer: restartable());
  }

  void _onDownloadLastBackup(BackupEventDownloadLastBackup event,Emitter<BackupState>emit)async{
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = _authService.currentUser;
    if(user == null){
      return;
    }
    emit(state.copyWith(loadingEnum: LoadingEnum.loading));

    final response = await _backupManager.downloadLastBackup(user);
    response.handle(
      onSuccess: (data){
        emit(state.copyWith(
            message: data,
            loadingEnum: LoadingEnum.completed,
            refreshApp: true
        ));
      },
      onError: (error){
        emit(state.copyWith(
            message: error,
            loadingEnum: LoadingEnum.completed
        ));
      }
    );
  }


  void _onDeleteAllUserData(BackupEventDeleteAllUserData event,Emitter<BackupState>emit)async{
    emit(state.copyWith(loadingEnum: LoadingEnum.loading));

    await _backupManager.deleteAllUserData();

    emit(state.copyWith(
      loadingEnum: LoadingEnum.completed,
      message: "Başarıyla silindi",
      refreshApp: true
    ));
  }


  void _onUploadBackup(BackupEventUploadBackup event,Emitter<BackupState>emit)async {
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = _authService.currentUser;
    if(user == null) return;

    emit(state.copyWith(loadingEnum: LoadingEnum.loading));

    final uploadResponse = await _backupManager.uploadBackup(user: user, isAuto: event.isAuto);
    final actionKey = event.actionKey;

    uploadResponse.handle(
      onSuccess: (data){
        emit(state.copyWith(
          message: data,
          loadingEnum: LoadingEnum.completed,
          actionResult: _getActionResult(actionKey, true)
        ));
      },
      onError: (error){
        emit(state.copyWith(
            message: error,
            loadingEnum: LoadingEnum.completed,
            actionResult: _getActionResult(actionKey, false)
        ));
      }
    );
  }

  void _onDownloadFile(BackupEventDownloadFile event,Emitter<BackupState>emit)async{
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = _authService.currentUser;
    if(user == null) return;

    emit(state.copyWith(loadingEnum: LoadingEnum.loading));

    final response = await _backupManager.downloadFile(
        fileName: event.fileName,
        user: user,
        deleteAllData: event.deleteAllLocalData
    );
    response.handle(
      onSuccess: (data){
        emit(state.copyWith(
          message: data,
          loadingEnum: LoadingEnum.completed,
          refreshApp: true
        ));
      },
      onError: (error){
        emit(state.copyWith(
          message: error,
          loadingEnum: LoadingEnum.completed
        ));
      }
    );
  }

  void _onClearActionResult(BackupEventClearActionResult event,Emitter<BackupState>emit){
    emit(state.copyWith(actionResult: null));
  }

  void _onClearCompletedLoading(BackupEventClearCompletedLoading event, Emitter<BackupState> emit){
    emit(state.copyWith(loadingEnum: LoadingEnum.idle));
  }

  void _onClearRefreshApp(BackupEventClearRefreshApp event, Emitter<BackupState> emit)async{
    emit(state.copyWith(refreshApp: false));
  }

  void _onClearMessage(BackupEventClearMessage event, Emitter<BackupState> emit){
    emit(state.copyWith(message: null));
  }

  Future<bool> _checkConnectionWithMessage(Emitter<BackupState> emit)async{
    if(await _connectivityService.hasConnected){
      return true;
    }
    emit(state.copyWith(message: "internet bağlantınızı kontrol ediniz"));
    return false;
  }

  ActionResult? _getActionResult(String? key, bool isSuccess){
    if(key == null) return null;
    return ActionResult(key: key,isSuccess: isSuccess);
  }

}