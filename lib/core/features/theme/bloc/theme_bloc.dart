


import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';

import 'theme_event.dart';
import 'theme_state.dart';


class ThemeBloc extends Bloc<IThemeEvent,ThemeState>{

  late final AppPreferences _appPreferences;

  ThemeBloc({
    required AppPreferences appPreferences
  }): super(ThemeState.init()){

    _appPreferences = appPreferences;

    on<ThemeEventListenAppPref>(_onListenAppPref,transformer: restartable());
    on<ThemeEventSetThemeType>(_onSetThemeType,transformer: restartable());
    on<ThemeEventClearMessage>(_onClearMessage,transformer: restartable());

    add(ThemeEventListenAppPref());
  }

  void _onSetThemeType(ThemeEventSetThemeType event, Emitter<ThemeState> emit)async{
    await _appPreferences.setEnumItem(KPref.themeTypeEnum, event.themeTypeEnum);
  }

  void _onListenAppPref(ThemeEventListenAppPref event, Emitter<ThemeState> emit)async{

    final themeEnum = _appPreferences.getEnumItem(KPref.themeTypeEnum);
    emit(state.copyWith(themeType: themeEnum));

    final streamData = _appPreferences.listenerFiltered([KPref.themeTypeEnum],initValue: null);

    await emit.forEach(streamData, onData: (data){
      final themeEnum = _appPreferences.getEnumItem(KPref.themeTypeEnum);
      return state.copyWith(themeType: themeEnum);
    });
  }

  void _onClearMessage(ThemeEventClearMessage event, Emitter<ThemeState> emit){
    emit(state.copyWith(message: null));
  }

}