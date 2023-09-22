

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';

import 'counter_setting_event.dart';
import 'counter_setting_state.dart';

class CounterSettingBloc extends Bloc<ICounterSettingEvent,CounterSettingState>{

  late final AppPreferences _appPreferences;

  CounterSettingBloc({
    required AppPreferences appPreferences
  }) : super(CounterSettingState.init()){

    _appPreferences = appPreferences;

    on<CounterSettingEventLoadData>(_onLoadData,transformer: droppable());
    on<CounterSettingEventSetEachDhikrVibration>(_onSetEachDhikrVibration,transformer: droppable());
    on<CounterSettingEventSetEndOfVibration>(_onSetEndOfTourVibration,transformer: droppable());
  }

  void _onLoadData(CounterSettingEventLoadData event,Emitter<CounterSettingState>emit)async{
    final eachDhikrVibration = _appPreferences.getItem(KPref.eachDhikrVibration);
    final endOfVibration = _appPreferences.getItem(KPref.eachEndOfTourVibration);

    emit(state.copyWith(
      eachDhikrVibration: eachDhikrVibration,
      eachEndOfTourVibration: endOfVibration
    ));
  }

  void _onSetEachDhikrVibration(CounterSettingEventSetEachDhikrVibration event,Emitter<CounterSettingState>emit)async{
    await _appPreferences.setItem(KPref.eachDhikrVibration, event.eachDhikrVibration);
    emit(state.copyWith(eachDhikrVibration: event.eachDhikrVibration));
  }
  void _onSetEndOfTourVibration(CounterSettingEventSetEndOfVibration event,Emitter<CounterSettingState>emit)async{
    await _appPreferences.setItem(KPref.eachEndOfTourVibration, event.endOfVibration);
    emit(state.copyWith(eachEndOfTourVibration: event.endOfVibration));
  }
}