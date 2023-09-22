

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/domain/manager/backup_manager.dart';
import 'package:hadith/core/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/services/auth_service.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';
import 'package:hadith/core/features/auth/bloc/auth_dialog_event.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<IAuthEvent,AuthState>{

  late final AuthService _authService;
  late final BackupManager _backupManager;
  late final AppPreferences _appPreferences;
  late final ConnectivityService _connectivityService;

  AuthBloc({
    required AuthService authService,
    required BackupManager backupManager,
    required AppPreferences appPreferences,
    required ConnectivityService connectivityService
  }): super(AuthState.init()){

    _authService = authService;
    _backupManager = backupManager;
    _appPreferences = appPreferences;
    _connectivityService = connectivityService;

    on<AuthEventSignIn>(_onSignIn,transformer: restartable());
    on<AuthEventSignOut>(_onSignOut,transformer: restartable());

    on<AuthEventSignOutWithBackup>(_onSignOutWithBackup,transformer: restartable());
    on<AuthEventListenAuthChange>(_onListenAuthChange,transformer: restartable());

    on<AuthEventHideDownloadBackupDia>(_onHideDownloadBackupDia,transformer: restartable());

    on<AuthEventClearMessage>(_onClearMessage,transformer: restartable());
    on<AuthEventClearDialogEvent>(_onClearDialogEvent,transformer: restartable());
    on<AuthEventClearCompletedLoading>(_onClearCompletedLoading,transformer: restartable());

    add(AuthEventListenAuthChange());
  }

  void _onListenAuthChange(AuthEventListenAuthChange event, Emitter<AuthState> emit)async{

    final user = _authService.currentUser;
    emit(state.copyWith(currentUser: user));

    final streamData = _authService.streamUser;

    await emit.forEach<AuthUser?>(streamData, onData: (user){
      return state.copyWith(currentUser: user);
    });
  }

  void _onSignIn(AuthEventSignIn event,Emitter<AuthState>emit)async{

    if(!await _checkConnectionWithMessage(emit)) return;
    emit(state.copyWith(loadingEnum: LoadingEnum.loading));

    final response = await _authService.signInWithGoogle();

    await response.handleAsync(
      onSuccess: (returnedUser)async{
        final downloadBackupResponse = await _backupManager.downloadLoginFiles(returnedUser);
        downloadBackupResponse.handle(
          onSuccess: (returnedBackupSize){
            final showDialog = returnedBackupSize > 0 && _appPreferences.getItem(KPref.showDownloadDiaInLogin);
            emit(state.copyWith(
              loadingEnum: LoadingEnum.completed,
              message: "Başarıyla giriş yapıldı",
              dialogEvent: showDialog ? AuthDialogEventShowDiaForDownloadBackup(): null
            ));
          },
          onError: (error){
            emit(state.copyWith(
              loadingEnum: LoadingEnum.completed,
              message: "Başarıyla giriş yapıldı. Yedek dosyaları alınırken bir hata oluştu"
            ));
          }
        );
      },
      onError: (error)async{
        emit(state.copyWith(
          loadingEnum: LoadingEnum.completed,
          message: error
        ));
      }
    );
  }

  void _onSignOutWithBackup(AuthEventSignOutWithBackup event,Emitter<AuthState>emit){
    emit(state.copyWith(
      dialogEvent: AuthDialogEventRequestAutoBackup()
    ));
  }

  void _onSignOut(AuthEventSignOut event,Emitter<AuthState>emit)async{
    final user = _authService.currentUser;
    if(user == null) return;

    emit(state.copyWith(loadingEnum: LoadingEnum.loading));

    await _backupManager.deleteAllSessionData(user);
    await _authService.signOut();

    emit(state.copyWith(
      loadingEnum: LoadingEnum.completed,
      message: "Başarıyla çıkış yapıldı"
    ));
  }

  void _onHideDownloadBackupDia(AuthEventHideDownloadBackupDia event, Emitter<AuthState> emit)async{
    await _appPreferences.setItem(KPref.showDownloadDiaInLogin, false);
  }


  void _onClearCompletedLoading(AuthEventClearCompletedLoading event, Emitter<AuthState> emit){
    emit(state.copyWith(loadingEnum: LoadingEnum.idle));
  }
  void _onClearDialogEvent(AuthEventClearDialogEvent event, Emitter<AuthState> emit)async{
    emit(state.copyWith(dialogEvent: null));
  }

  void _onClearMessage(AuthEventClearMessage event, Emitter<AuthState> emit){
    emit(state.copyWith(message: null));
  }


  Future<bool> _checkConnectionWithMessage(Emitter<AuthState> emit)async{
    if(await _connectivityService.hasConnected){
      return true;
    }
    emit(state.copyWith(message: "internet bağlantınızı kontrol ediniz"));
    return false;
  }

}