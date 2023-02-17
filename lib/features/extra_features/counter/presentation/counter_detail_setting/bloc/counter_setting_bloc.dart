

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail_setting/bloc/counter_setting_event.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail_setting/bloc/counter_setting_state.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterSettingBloc extends Bloc<ICounterSettingEvent,CounterSettingState>{

  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  CounterSettingBloc() : super(CounterSettingState.init()){

    on<CounterSettingEventSetInit>(_onInit,transformer: droppable());
    on<CounterSettingEventSetEachDhikrVibration>(_onSetEachDhikrVibration,transformer: droppable());
    on<CounterSettingEventSetEndOfVibration>(_onSetEndOfTourVibration,transformer: droppable());

  }

  void _onInit(CounterSettingEventSetInit event,Emitter<CounterSettingState>emit)async{
    final eachDhikrVibration = _sharedPreferences.getBool(PrefConstants.eachDhikrVibration.key) ??
        PrefConstants.eachDhikrVibration.defaultValue;

    final endOfVibration = _sharedPreferences.getBool(PrefConstants.eachEndOfTourVibration.key) ??
        PrefConstants.eachEndOfTourVibration.defaultValue;

    emit(state.copyWith(
      eachDhikrVibration: eachDhikrVibration,
      eachEndOfTourVibration: endOfVibration
    ));
  }

  void _onSetEachDhikrVibration(CounterSettingEventSetEachDhikrVibration event,Emitter<CounterSettingState>emit)async{
    await _sharedPreferences.setBool(PrefConstants.eachDhikrVibration.key, event.eachDhikrVibration);
    emit(state.copyWith(eachDhikrVibration: event.eachDhikrVibration));
  }
  void _onSetEndOfTourVibration(CounterSettingEventSetEndOfVibration event,Emitter<CounterSettingState>emit)async{
    await _sharedPreferences.setBool(PrefConstants.eachEndOfTourVibration.key, event.endOfVibration);
    emit(state.copyWith(eachEndOfTourVibration: event.endOfVibration));
  }
}