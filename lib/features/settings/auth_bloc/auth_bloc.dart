

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/features/settings/auth_bloc/auth_event.dart';
import 'package:hadith/features/settings/auth_bloc/auth_state.dart';
import 'package:hadith/features/backup/backup_manager.dart';
import 'package:hadith/features/settings/loading_enum.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/services/auth_service.dart';
import 'package:hadith/services/connectivity_service.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBlocOld extends Bloc<IAuthEventOld,AuthStateOld>{

  late final AuthServiceOld _authService;
  late final BackupManager _backupManager;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  AuthBlocOld({required AuthServiceOld authService,required BackupManager backupManager}) : super(AuthStateOld.init()){
    _authService = authService;
    _backupManager = backupManager;

    on<AuthEventSignIn>(_onSignIn,transformer: restartable());
    on<AuthEventSignOut>(_onSignOut,transformer: restartable());
    on<AuthEventInit>(_onInit);
    on<AuthEventDoNotShowDialog>(_onDoNotShowDialog,transformer: restartable());
    on<AuthEventDownloadLastBackup>(_onDownloadLastBackup,transformer: restartable());
    on<AuthEventDeleteAllLocalData>(_onDeleteAllData,transformer: restartable());
    on<AuthEventUploadAutoBackup>(_onUploadAutoBackup,transformer: restartable());
    on<AuthEventUploadBackup>(_onUploadBackup,transformer: restartable());
    on<AuthEventRefreshFiles>(_onRefreshFiles,transformer: restartable());
    on<AuthEventDownloadFile>(_onDownloadFile,transformer: restartable());

    add(AuthEventInit());
  }

  void _onInit(AuthEventInit event,Emitter<AuthStateOld>emit)async{

    await emit.forEach<User?>(_authService.streamUser(), onData: (user){
      return state.copyWith(user: user,setUser: true);
    });
  }

  void _addMessage(String message,Emitter<AuthStateOld>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true));
  }

  void _setLoading(bool isLoading,Emitter<AuthStateOld>emit){
    if(isLoading){
      if(state.loadingEnum!=LoadingEnum.loading){
        emit(state.copyWith(loadingEnum: LoadingEnum.loading));
      }
    }else{
      if(state.loadingEnum!=LoadingEnum.complete){
        emit(state.copyWith(loadingEnum: LoadingEnum.complete));
      }
    }
  }

  Future<bool> _checkConnectionWithMessage(Emitter<AuthStateOld>emit)async{
    if(await ConnectivityService.isConnectedInternet()){
      return true;
    }
    _addMessage("internet bağlantınızı kontrol ediniz", emit);
    return false;
  }

  void _onSignIn(AuthEventSignIn event,Emitter<AuthStateOld>emit)async{

    if(!await _checkConnectionWithMessage(emit)) return;
    _setLoading(true, emit);

    final response = await _authService.signInWithGoogle();
    _setLoading(false, emit);

    if(response is ResourceSuccess<String>){
      final user = state.user;
      if(user!=null){
        _setLoading(true, emit);

        final responseDownloadBackups=await _backupManager.downloadLoginFiles(user);
        _setLoading(false, emit);

        if(responseDownloadBackups is ResourceSuccess<int>){
          final showDialog = responseDownloadBackups.data>0 && (_sharedPreferences.getBool(PrefConstants.showDownloadDiaInLogin.key)
              ??PrefConstants.showDownloadDiaInLogin.defaultValue);

          _addMessage(response.data, emit);
          emit(state.copyWith(showDialogForDownloadBackup: showDialog));
          emit(state.copyWith(showDialogForDownloadBackup: false));
        }else{
          _addMessage("Bir şeyler yanlış gitti", emit);
        }
      }
    }else if(response is ResourceError<String>){
      _addMessage(response.error, emit);
    }
  }

  void _onSignOut(AuthEventSignOut event,Emitter<AuthStateOld>emit)async{

    _setLoading(true, emit);
    final user = state.user;
    if(user!=null){
      await _authService.signOut();
      await _backupManager.logOutRemoveFiles(user);
      _addMessage("Başarıyla çıkış yapıldı", emit);
    }
    _setLoading(false, emit);

  }

  void _onDoNotShowDialog(AuthEventDoNotShowDialog event,Emitter<AuthStateOld>emit)async{
    await _sharedPreferences.setBool(PrefConstants.showDownloadDiaInLogin.key, false);
  }

  void _onDownloadLastBackup(AuthEventDownloadLastBackup event,Emitter<AuthStateOld>emit)async{
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = state.user;
    if(user == null){
      return;
    }
    _setLoading(true, emit);
    final response = await _backupManager.downloadLastBackup(user);
    _setLoading(false, emit);
    if(response is ResourceSuccess<String>){
      _addMessage(response.data, emit);
      emit(state.copyWith(refreshApp: true));
      emit(state.copyWith(refreshApp: false));
      return;
    }else if(response is ResourceError<String>){
      _addMessage(response.error, emit);
    }
  }


  void _onDeleteAllData(AuthEventDeleteAllLocalData event,Emitter<AuthStateOld>emit)async{

    _setLoading(true, emit);
    await _backupManager.deleteAllData();
    _setLoading(false, emit);
    _addMessage("başarıyla silindi", emit);
    emit(state.copyWith(refreshApp: true));
    emit(state.copyWith(refreshApp: false));

  }


  void _onUploadAutoBackup(AuthEventUploadAutoBackup event,Emitter<AuthStateOld>emit)async {
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = state.user;
    if (user != null) {
      _setLoading(true, emit);
      final uploadResponse = await _backupManager.uploadBackup(user, true);
      _setLoading(false, emit);
      if (uploadResponse is ResourceSuccess<String>) {
        emit(state.copyWith(hasUploadAutoBackup: true));
        emit(state.copyWith(hasUploadAutoBackup: false));
      } else if (uploadResponse is ResourceError<String>) {
        emit(state.copyWith(askReUploadAutoBackup: true));
        emit(state.copyWith(askReUploadAutoBackup: false));
      }
    }
  }

  void _onUploadBackup(AuthEventUploadBackup event,Emitter<AuthStateOld>emit)async {
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = state.user;
    if (user != null) {
      _setLoading(true, emit);
      final uploadResponse = await _backupManager.uploadBackup(user, false);
      _setLoading(false, emit);
      if (uploadResponse is ResourceSuccess<String>) {
        _addMessage("Başarılı", emit);
      } else if (uploadResponse is ResourceError<String>) {
        emit(state.copyWith(askReUploadAutoBackup: true));
        emit(state.copyWith(askReUploadAutoBackup: false));
        _addMessage(uploadResponse.error, emit);
      }
    }
  }

  void _onRefreshFiles(AuthEventRefreshFiles event,Emitter<AuthStateOld>emit)async{
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = state.user;
    if(user!=null){
      _setLoading(true, emit);
      final response = await _backupManager.refreshFiles(user);
      _setLoading(false, emit);
      if (response is ResourceSuccess<String>) {
        _addMessage("Başarılı", emit);
      } else if (response is ResourceError<String>) {
        _addMessage(response.error, emit);
      }
    }
  }

  void _onDownloadFile(AuthEventDownloadFile event,Emitter<AuthStateOld>emit)async{
    if(!await _checkConnectionWithMessage(emit)) return;

    final user = state.user;
    if(user!=null){
      _setLoading(true, emit);
      final response = await _backupManager.downloadFile(event.fileName,user,event.deleteAllLocalData);
      _setLoading(false, emit);
      if (response is ResourceSuccess<String>) {
        _addMessage(response.data, emit);
        emit(state.copyWith(refreshApp: true));
        emit(state.copyWith(refreshApp: false));
      } else if (response is ResourceError<String>) {
        _addMessage(response.error, emit);
      }
    }
  }
}
