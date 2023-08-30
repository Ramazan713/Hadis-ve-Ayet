import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/domain/manager/backup_manager.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/backup/backup_meta_repo.dart';
import 'package:hadith/core/domain/services/auth_service.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';

import 'backup_meta_event.dart';
import 'backup_meta_state.dart';

class BackupMetaBloc extends Bloc<IBackupMetaEvent,BackupMetaState>{

  late final AuthService _authService;
  late final BackupManager _backupManager;
  late final ConnectivityService _connectivityService;
  late final AppPreferences _appPreferences;
  late final BackupMetaRepo _backupMetaRepo;

  BackupMetaBloc({
    required AuthService authService,
    required BackupManager backupManager,
    required ConnectivityService connectivityService,
    required AppPreferences appPreferences,
    required BackupMetaRepo backupMetaRepo
  }) : super(BackupMetaState.init()){

    _authService = authService;
    _backupManager = backupManager;
    _connectivityService = connectivityService;
    _appPreferences = appPreferences;
    _backupMetaRepo = backupMetaRepo;


    on<BackupMetaEventSelectBackupMeta>(_onSelectBackup,transformer: restartable());
    on<BackupMetaEventRefresh>(_onRefresh,transformer: restartable());
    on<BackupMetaEventListenData>(_onListenData,transformer: restartable());
    on<BackupMetaEventSetCounter>(_onSetCounter,transformer: restartable());
    on<BackupMetaEventClearMessage>(_onClearMessage,transformer: restartable());

    add(BackupMetaEventListenData());
  }


  void _onListenData(BackupMetaEventListenData event,Emitter<BackupMetaState>emit)async{
    final dataStream = _backupMetaRepo.getStreamBackupModels();
    await emit.forEach<List<BackupMetaModel>>(dataStream, onData: (data){
      return state.copyWith(items: data);
    });
  }


  void _onRefresh(BackupMetaEventRefresh event,Emitter<BackupMetaState>emit)async{
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = _authService.currentUser;
    if(user!=null){
      emit(state.copyWith(isLoading: true));

      await _appPreferences.setItem(KPref.counterBackupDate, DateTime.now().toIso8601String());
      _callTimer();

      final response = await _backupManager.refreshBackupFiles(user);
      emit(state.copyWith(
          isRefreshDisabled: true,
          isLoading: false
      ));

      response.handle(
        onSuccess: (data){
          emit(state.copyWith(
            message: data
          ));
        },
        onError: (error){
          emit(state.copyWith(
            message: error
          ));
        }
      );
    }
  }

  void _onSelectBackup(BackupMetaEventSelectBackupMeta event,Emitter<BackupMetaState>emit)async{
    emit(state.copyWith(selectedItem: event.backupMeta));
  }

  void _onClearMessage(BackupMetaEventClearMessage event,Emitter<BackupMetaState>emit){
    emit(state.copyWith(message: null));
  }

  void _onSetCounter(BackupMetaEventSetCounter event,Emitter<BackupMetaState>emit)async{
    emit(state.copyWith(
        counter: event.counter??"",
        isRefreshDisabled: event.isDisableRefresh
    ));
  }



  void _callTimer() {
    final dateText = _appPreferences.getItem(KPref.counterBackupDate);

    if (dateText != "") {
      final DateTime? prevDate = DateTime.tryParse(dateText);
      if (prevDate != null) {
        final diffSeconds = DateTime.now().difference(prevDate).inSeconds;
        if (diffSeconds <= K.waitingRefreshTimeForBackupMeta) {
          final longSeconds = K.waitingRefreshTimeForBackupMeta - diffSeconds;
          add(BackupMetaEventSetCounter(counter: longSeconds.toString(),isDisableRefresh: true));

          Timer.periodic(const Duration(seconds: 1), (timer) {
              final value = longSeconds - timer.tick;
              if (value == 0) {
                timer.cancel();
                add(BackupMetaEventSetCounter(counter: "", isDisableRefresh: false));
              } else {
                add(BackupMetaEventSetCounter(counter: "$value", isDisableRefresh: true));
              }
          });
        }
      }
    }
  }

  Future<bool>_checkConnectionWithMessage(Emitter<BackupMetaState>emit)async{
    if(await _connectivityService.hasConnected){
      return true;
    }
    emit(state.copyWith(message: "internet bağlantınızı kontrol ediniz"));
    return false;
  }

}