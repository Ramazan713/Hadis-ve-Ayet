import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/db/entities/backup_meta.dart';
import 'package:hadith/db/repos/backup_meta_repo.dart';
import 'package:hadith/features/backup/backup_manager.dart';
import 'package:hadith/features/backup/backup_meta/bloc/backup_meta_event.dart';
import 'package:hadith/features/backup/backup_meta/bloc/backup_meta_state.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/services/auth_service.dart';
import 'package:hadith/services/connectivity_service.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackupMetaBlocOld extends Bloc<IBackupMetaEvent,BackupMetaState>{
  late final BackupMetaRepoOld _backupMetaRepo;
  late final BackupManager _backupManager;
  late final AuthServiceOld _authService;

  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  BackupMetaBlocOld({required BackupMetaRepoOld backupMetaRepo,required BackupManager backupManager,
    required AuthServiceOld authService}) : super(BackupMetaState.init()){

    _backupManager = backupManager;
    _backupMetaRepo = backupMetaRepo;
    _authService = authService;

    on<BackupMetaEventSelectBackupMeta>(_onSelectBackup,transformer: restartable());
    on<BackupMetaEventRefresh>(_onRefresh,transformer: restartable());
    on<BackupMetaEventInit>(_onInit,transformer: restartable());
    on<BackupMetaEventSetCounter>(_onSetCounter,transformer: restartable());

    add(BackupMetaEventInit());

  }


  void _onInit(BackupMetaEventInit event,Emitter<BackupMetaState>emit)async{
    final dataStream = _backupMetaRepo.getStreamBackupMetas();
    await emit.forEach<List<BackupMetaOld>>(dataStream, onData: (data)=>
        state.copyWith(status: DataStatus.success,backupMetas: data));
  }
  void _onRefresh(BackupMetaEventRefresh event,Emitter<BackupMetaState>emit)async{
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = _authService.currentUser();
    if(user!=null){
      emit(state.copyWith(status: DataStatus.loading));

      await _sharedPreferences.setString(PrefConstants.counterBackupDate.key, DateTime.now().toIso8601String());
      _callTimer();

      final response = await _backupManager.downloadLastBackup(user);
      emit(state.copyWith(isDisableRefresh: true,status: DataStatus.success));

      if(response is ResourceSuccess<String>){
        _addMessage(response.data, emit);
      }else if(response is ResourceError<String>){
        _addMessage(response.error, emit);
      }
    }


  }

  void _onSelectBackup(BackupMetaEventSelectBackupMeta event,Emitter<BackupMetaState>emit)async{
    emit(state.copyWith(selectedBackup: event.backupMeta,setBackupMeta: true));
  }

  void _onSetCounter(BackupMetaEventSetCounter event,Emitter<BackupMetaState>emit)async{
    emit(state.copyWith(counter: event.counter,isDisableRefresh: event.isDisableRefresh));
  }



  void _callTimer() {
    final dateText = _sharedPreferences.getString(PrefConstants.counterBackupDate.key) ?? "";

    if (dateText != "") {
      final DateTime? prevDate = DateTime.tryParse(dateText);
      if (prevDate != null) {
        final diffSeconds = DateTime.now().difference(prevDate).inSeconds;
        if (diffSeconds <= kWaitingRefreshTime) {
          final longSeconds = kWaitingRefreshTime - diffSeconds;
          add(BackupMetaEventSetCounter(counter: longSeconds.toString(),isDisableRefresh: true));
          Timer.periodic(const Duration(seconds: 1), (timer) {
              final value = longSeconds - timer.tick;
              if (value == 0) {
                timer.cancel();
                add(BackupMetaEventSetCounter(counter: "",isDisableRefresh: false));
              } else {
                add(BackupMetaEventSetCounter(counter: "$value",isDisableRefresh: true));
              }
          });
        }
      }
    }
  }


  void _addMessage(String message,Emitter<BackupMetaState>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true));
  }

  Future<bool>_checkConnectionWithMessage(Emitter<BackupMetaState>emit)async{
    if(await ConnectivityService.isConnectedInternet()){
      return true;
    }
    _addMessage("internet bağlantınızı kontrol ediniz", emit);
    return false;
  }

}