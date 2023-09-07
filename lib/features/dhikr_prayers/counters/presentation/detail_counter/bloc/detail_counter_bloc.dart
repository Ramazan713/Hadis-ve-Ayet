
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/use_case/extract_counter_info_use_case.dart';
import 'package:vibration/vibration.dart';

import 'detail_detail_event.dart';
import 'detail_counter_state.dart';

class DetailCounterBloc extends Bloc<IDetailCounterEvent,DetailCounterState>{


  final tourNumber = 99;
  final extractCounterInfoUseCase = ExtractCounterInfoUseCase();

  late final CounterRepo _counterRepo;
  late final AppPreferences _appPreferences;
  late final FontModelUseCase _fontModelUseCase;

  DetailCounterBloc({
    required CounterRepo counterRepo,
    required AppPreferences appPreferences,
    required FontModelUseCase fontModelUseCase,
  }) : super(DetailCounterState.init()){

    _counterRepo = counterRepo;
    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;

    on<DetailCounterEventListenAppPref>(_onListenAppPref);
    on<CounterDetailEventListenCounter>(_onListenCounter,transformer: restartable());

    on<DetailCounterEventIncrease>(_onIncrease,transformer: restartable());
    on<DetailCounterEventReset>(_onReset,transformer: restartable());

    on<DetailCounterEventLoadData>(_onLoadData,transformer: restartable());
    on<DetailCounterEventLoadDataWithCounterType>(_onLoadDataWithCounterType,transformer: restartable());
    on<DetailCounterEventLoadDataWithCounterId>(_onLoadDataWithCounterId,transformer: restartable());

    add(DetailCounterEventListenAppPref());
  }

  void _onLoadDataWithCounterId(DetailCounterEventLoadDataWithCounterId event,Emitter<DetailCounterState>emit)async{
    final counter = await _counterRepo.getCounterById(event.counterId);
    add(DetailCounterEventLoadData(counter: counter,counterType: counter?.counterType ?? CounterType.classic));
  }

  void _onLoadDataWithCounterType(DetailCounterEventLoadDataWithCounterType event,Emitter<DetailCounterState>emit)async{
    add(DetailCounterEventLoadData(counterType: event.counterType,counter: null));
  }

  void _onLoadData(DetailCounterEventLoadData event,Emitter<DetailCounterState>emit)async{
    final fontModel = _fontModelUseCase.call();
    final verseUi = _appPreferences.getEnumItem(KPref.counterUi);
    final hasVibrator = await Vibration.hasVibrator() == true;
    final counterInfo = _getInitCounterInfo(event.counter);
    final eachDhikrVibration = _appPreferences.getItem(KPref.eachDhikrVibration);
    final eachEndOfTourVibration = _appPreferences.getItem(KPref.eachEndOfTourVibration);

    final counter = event.counter;
    if(counter!=null&&counter.id!=null){
      add(CounterDetailEventListenCounter(counter: counter));
    }

    emit(state.copyWith(
      currentCounter: counter,
      hasCompletedGoal: false,
      fontModel: fontModel,
      hasVibrate: hasVibrator,
      counterSubClassic: counterInfo.subCounterBase,
      counterUnLimited: counterInfo.counter,
      counterClassic: counterInfo.counterBase,
      counterType: event.counterType,
      verseUi: verseUi,
      enabledEachDhikrVibration: eachDhikrVibration,
      enabledEachEndOfTourVibration: eachEndOfTourVibration
    ));
  }


  void _onIncrease(DetailCounterEventIncrease event,Emitter<DetailCounterState>emit)async{

    final CounterInfo updated = extractCounterInfoUseCase.call(
      state.counterUnLimited + 1,
      base: tourNumber
    );

    final reachedGoal = state.getGoal!=null && state.getGoal! <= updated.counter;

    _vibrateEachDhikr();

    if(reachedGoal || (state.counterType == CounterType.classic && updated.counterBase == tourNumber)){
      _vibrateEachTour();
    }

    EasyDebounce.debounce("counter_update_last_count", const Duration(seconds: 1), () async{
      await _updateLastCounter();
    });

    emit(state.copyWith(
        counterUnLimited: updated.counter,
        counterClassic: updated.counterBase,
        counterSubClassic: updated.subCounterBase,
        hasCompletedGoal: reachedGoal
    ));
  }

  void _onReset(DetailCounterEventReset event,Emitter<DetailCounterState>emit)async{
    emit(state.copyWith(
        counterUnLimited: 0,
        counterClassic: 0,
        counterSubClassic: 0,
        hasCompletedGoal: false,

    ));
    await _updateLastCounter();
  }

  void _onListenCounter(CounterDetailEventListenCounter event,Emitter<DetailCounterState>emit)async{
    final streamData = _counterRepo.getStreamCounterById(event.counter.id ?? 0);


    await emit.forEach<Counter?>(streamData, onData: (data){
      return state.copyWith(currentCounter: data);
    });
  }

  void _onListenAppPref(DetailCounterEventListenAppPref event,Emitter<DetailCounterState>emit)async{
    final streamData = _appPreferences.listenerFiltered([
      KPref.fontSizeContent,
      KPref.fontFamilyArabic,
      KPref.fontSizeArabic,
      KPref.counterUi,
      KPref.eachDhikrVibration,
      KPref.eachEndOfTourVibration
    ], initValue: null);

    emit(state.copyWith(
        fontModel: _fontModelUseCase()
    ));

    await emit.forEach(streamData, onData: (key){
      final verseUi = _appPreferences.getEnumItem(KPref.counterUi);
      final eachDhikrVibration = _appPreferences.getItem(KPref.eachDhikrVibration);
      final eachEndOfTourVibration = _appPreferences.getItem(KPref.eachEndOfTourVibration);

      return state.copyWith(
        fontModel: _fontModelUseCase(),
        verseUi: verseUi,
        enabledEachDhikrVibration: eachDhikrVibration,
        enabledEachEndOfTourVibration: eachEndOfTourVibration
      );
    });
  }


  void _vibrateEachTour()async{
    if(state.eachEndOfTourVibration){
      Vibration.vibrate(duration: 250);
    }
  }

  void _vibrateEachDhikr()async{
    if(state.eachDhikrVibration){
      Vibration.vibrate(duration: 30);
    }
  }

  Future<void> _updateLastCounter()async{
    final counter = state.currentCounter;
    if(counter!=null && counter.id!=null){
      final lastCounter = state.counterUnLimited;
      final updatedCounter = counter.copyWith(lastCounter: lastCounter);
      await _counterRepo.updateCounter(updatedCounter);
    }
    else if(counter == null){
      await _appPreferences.setItem(KPref.defaultLastCounter, state.counterUnLimited);
    }
  }

  CounterInfo _getInitCounterInfo(Counter? counter){
    final int startCounter;
    if(counter!=null && counter.id!=null){
      startCounter = counter.lastCounter;
    }else if(counter == null){
      startCounter = _appPreferences.getItem(KPref.defaultLastCounter);
    }else{
      startCounter = 0;
    }
    return extractCounterInfoUseCase.call(startCounter,base: tourNumber);
  }

}