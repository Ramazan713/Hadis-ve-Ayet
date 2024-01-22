


import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/core/domain/repo/user_info_repo.dart';
import 'package:hadith/core/features/auth/domain/services/auth_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<ISettingsEvent,SettingsState>{

  late final AppPreferences _appPreferences;
  late final FontModelUseCase _fontModelUseCase;
  late final UserInfoRepo _userInfoRepo;
  late final AuthService _authService;

  final BehaviorSubject<String?> _userIdController = BehaviorSubject();

  SettingsBloc({
    required AppPreferences appPreferences,
    required FontModelUseCase fontModelUseCase,
    required UserInfoRepo userInfoRepo,
    required AuthService authService
  }): super(SettingsState.init()){

    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;
    _userInfoRepo = userInfoRepo;
    _authService = authService;

    on<SettingsEventLoadData>(_onLoadData,transformer: restartable());
    on<SettingsEventListenAppPref>(_onListenAppPref,transformer: restartable());
    on<SettingsEventListenUserInfo>(_onListenUserInfo,transformer: restartable());

    on<SettingsEventSetArchiveAsList>(_onSetArchiveAsList,transformer: restartable());
    on<SettingsEventSetShowListIcons>(_onSetShowListIcons,transformer: restartable());
    on<SettingsEventResetSettings>(_onResetSettings,transformer: restartable());
    on<SettingsEventRequestUserInfo>(_onRequestUserInfo,transformer: restartable());

    add(SettingsEventListenAppPref());
    add(SettingsEventListenUserInfo());
  }

  void _onLoadData(SettingsEventLoadData event,Emitter<SettingsState>emit)async{
    final prefUpdatedState = _getUpdatedPrefState(state: state);
    final packageInfo = await PackageInfo.fromPlatform();
    emit(prefUpdatedState.copyWith(
      packageInfo: packageInfo.packageName
    ));
    _userIdController.value = _authService.currentUser?.uid;
  }

  void _onRequestUserInfo(SettingsEventRequestUserInfo event,Emitter<SettingsState>emit)async{
    _userIdController.value = event.userId;
  }

  void _onSetArchiveAsList(SettingsEventSetArchiveAsList event,Emitter<SettingsState>emit)async{
    await _appPreferences.setItem(KPref.useArchiveListFeatures, event.archiveAsList);
    emit(state.copyWith(useArchiveAsSelectList: event.archiveAsList));
  }

  void _onSetShowListIcons(SettingsEventSetShowListIcons event,Emitter<SettingsState>emit)async{
    await _appPreferences.setItem(KPref.showVerseListIcons, event.showListIcons);
    emit(state.copyWith(showSelectedListVerseIcons: event.showListIcons));
  }

  void _onResetSettings(SettingsEventResetSettings event,Emitter<SettingsState>emit)async{
    await _appPreferences.clear();
    emit(_getUpdatedPrefState(state: state));
  }

  void _onListenUserInfo(SettingsEventListenUserInfo event,Emitter<SettingsState>emit)async{
    final streamData = _userIdController.distinct().switchMap((userId){
      return _userInfoRepo.getStreamUserInfoWithId(userId??"");
    });
    await emit.forEach(streamData, onData: (userInfo){
      return state.copyWith(currentUserInfo: userInfo);
    });
  }

  void _onListenAppPref(SettingsEventListenAppPref event,Emitter<SettingsState>emit)async{
    final streamData = _appPreferences.listener;
    await emit.forEach(streamData, onData: (key){
      return _getUpdatedPrefState(state: state);
    });
  }


  SettingsState _getUpdatedPrefState({
    required SettingsState state
  }){
    final useArchiveListFeatures = _appPreferences.getItem(KPref.useArchiveListFeatures);
    final showVerseListIcons = _appPreferences.getItem(KPref.showVerseListIcons);
    final verseUI = _appPreferences.getEnumItem(KPref.verseAppearanceEnum);
    final searchCriteria = _appPreferences.getEnumItem(KPref.searchCriteriaEnum);
    final fontModel = _fontModelUseCase();
    
    return state.copyWith(
      useArchiveAsSelectList: useArchiveListFeatures,
      showSelectedListVerseIcons: showVerseListIcons,
      verseUI: verseUI,
      searchCriteria: searchCriteria,
      fontModel: fontModel
    );
  }
  
}