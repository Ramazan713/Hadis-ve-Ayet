


import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
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
    on<ThemeEventInit>(_onInit,transformer: restartable());
    on<ThemeEventSetThemeType>(_onSetThemeType,transformer: restartable());
    on<ThemeEventSetUseDynamicColor>(_onSetUseDynamicColor,transformer: restartable());
    on<ThemeEventClearMessage>(_onClearMessage,transformer: restartable());

    add(ThemeEventListenAppPref());
    add(ThemeEventInit());
  }

  void _onInit(ThemeEventInit event, Emitter<ThemeState> emit)async{
    final dynamicColorsSupported = (await DynamicColorPlugin.getCorePalette()) != null;

    emit(state.copyWith(dynamicColorSupported: dynamicColorsSupported));
  }

  void _onSetUseDynamicColor(ThemeEventSetUseDynamicColor event, Emitter<ThemeState> emit)async{
    await _appPreferences.setItem(KPref.useDynamicColors, event.useDynamicColors);
  }

  void _onSetThemeType(ThemeEventSetThemeType event, Emitter<ThemeState> emit)async{
    await _appPreferences.setEnumItem(KPref.themeTypeEnum, event.themeTypeEnum);
  }

  void _onListenAppPref(ThemeEventListenAppPref event, Emitter<ThemeState> emit)async{

    final themeEnum = _appPreferences.getEnumItem(KPref.themeTypeEnum);
    final useDynamicColors = _appPreferences.getItem(KPref.useDynamicColors);

    emit(state.copyWith(
      themeType: themeEnum,
      useDynamicColors: useDynamicColors,
    ));

    final streamData = _appPreferences.listenerFiltered([KPref.themeTypeEnum,KPref.useDynamicColors],initValue: null);

    await emit.forEach(streamData, onData: (data){
      final themeEnum = _appPreferences.getEnumItem(KPref.themeTypeEnum);
      final useDynamicColors = _appPreferences.getItem(KPref.useDynamicColors);

      return state.copyWith(
        themeType: themeEnum,
        useDynamicColors: useDynamicColors
      );
    });
  }

  void _onClearMessage(ThemeEventClearMessage event, Emitter<ThemeState> emit){
    emit(state.copyWith(message: null));
  }

}