

import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';
import 'package:hadith/features/extra_features/counter/domain/repo/counter_repo.dart';
import 'package:hadith/features/extra_features/counter/domain/use_case/extract_counter_info_use_case.dart';
import 'package:hadith/features/extra_features/counter/domain/use_case/insert_counter_use_case.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_event.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_state.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class CounterDetailBloc extends Bloc<ICounterDetailEvent,CounterDetailState>{


  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;
  final tourNumber = 99;
  final extractCounterInfoUseCase = ExtractCounterInfoUseCase();
  late final InsertCounterUseCase _insertCounterUseCase;

  late final CounterRepoOld _counterRepo;

  Timer? _timer;

  CounterDetailBloc({required CounterRepoOld counterRepo,required InsertCounterUseCase insertCounterUseCase}) : super(CounterDetailState.init()){
    _counterRepo = counterRepo;
    _insertCounterUseCase = insertCounterUseCase;

    on<CounterDetailEventIncrease>(_onIncrease,transformer: restartable());
    on<CounterDetailEventInit>(_onInit);
    on<CounterDetailEventReset>(_onReset,transformer: restartable());
    on<CounterDetailEventSetInit>(_onSetInit,transformer: restartable());
    on<CounterDetailEventSetCounterUi>(_onSetCounterUi,transformer: restartable());
    on<CounterDetailEventAddCounter>(_onAddCounter,transformer: restartable());
    on<CounterDetailEventStartListenCounter>(_onStartListening,transformer: restartable());


    add(CounterDetailEventInit());
  }

  void _onInit(CounterDetailEventInit event,Emitter<CounterDetailState>emit)async{
    await emit.forEach<FontSize>(FontSizeHelper.streamFontSize,
        onData: (data)=>state.copyWith(fontSize: data.size));
  }

  void _onSetInit(CounterDetailEventSetInit event,Emitter<CounterDetailState>emit)async{
    final fontIndex = _sharedPreferences.getInt(PrefConstants.fontSize.key) ??
        PrefConstants.fontSize.defaultValue;
    final fontSize = FontSize.values[fontIndex];

    final counterUiIndex = _sharedPreferences.getInt(PrefConstants.counterUi.key) ??
        PrefConstants.counterUi.defaultValue;
    final verseUi3X = ArabicVerseUI3X.values[counterUiIndex];

    final hasVibrator = await Vibration.hasVibrator() == true;

    final counterInfo = _getInitCounterInfo(event);
    final counter = event.counter;
    if(counter!=null&&counter.id!=null){
      add(CounterDetailEventStartListenCounter(counter: counter));
    }
    emit(state.copyWith(counter: counter,setCounter: true,hasCompletedGoal: false,
        fontSize: fontSize.size,hasVibrator: hasVibrator,
        counterSubClassic: counterInfo.subCounterBase,
        counterUnLimited: counterInfo.counter,
        counterClassic: counterInfo.counterBase,
        counterType: event.counterType,
        verseUi3X: verseUi3X
    ));
  }

  void _onStartListening(CounterDetailEventStartListenCounter event,Emitter<CounterDetailState>emit)async{
    await emit.forEach<Counter?>(_counterRepo.getStreamCounterById(event.counter.id??0),
        onData: (data)=>state.copyWith(counter: data,setCounter: true,
            counterType: data?.counterType)
    );
  }

  CounterInfo _getInitCounterInfo(CounterDetailEventSetInit event){
    final int startCounter;
    if(event.counter!=null && event.counter?.id!=null){
      startCounter = event.counter?.lastCounter??0;
    }else if(event.counter == null){
      startCounter = _sharedPreferences.getInt(PrefConstants.defaultLastCounter.key)??0;
    }else{
      startCounter = 0;
    }
    return extractCounterInfoUseCase.operator(startCounter,base: tourNumber);
  }


  void _onIncrease(CounterDetailEventIncrease event,Emitter<CounterDetailState>emit)async{

    final CounterInfo updated = extractCounterInfoUseCase.operator(
      state.counterUnLimited + 1,
      base: tourNumber
    );

    final reachedGoal = state.getGoal()!=null && state.getGoal()! <= updated.counter;

    _vibrateEachDhikr();

    if(reachedGoal || (state.counterType == CounterType.classic && updated.counterBase == tourNumber)){
      _vibrateEachTour();
    }

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), () async{
      await updateLastCounter(emit);
    });

    emit(state.copyWith(
        counterUnLimited: updated.counter,
        counterClassic: updated.counterBase,
        counterSubClassic: updated.subCounterBase,
        hasCompletedGoal: reachedGoal
    ));
  }

  void _onReset(CounterDetailEventReset event,Emitter<CounterDetailState>emit)async{
    emit(state.copyWith(
        counterUnLimited: 0,
        counterClassic: 0,
        counterSubClassic: 0,
        hasCompletedGoal: false,

    ));
    await updateLastCounter(emit);
  }

  void _onSetCounterUi(CounterDetailEventSetCounterUi event,Emitter<CounterDetailState>emit)async{
    emit(state.copyWith(verseUi3X: event.counterUi));
  }

  void _onAddCounter(CounterDetailEventAddCounter event,Emitter<CounterDetailState>emit)async{
    final counter = state.counter;
    if(state.hasNotSavedCounter() && counter!=null){
      final id = await _insertCounterUseCase.operator(
          name: counter.name,
          counterType: counter.counterType,
          lastCounter: state.counterUnLimited,
          content: counter.content,
          goal: counter.goal,
          arabicContent: counter.arabicContent,
          meaning: counter.meaning
      );
      final updatedCounter = (await _counterRepo.getCounterById(id))??counter;
      add(CounterDetailEventStartListenCounter(counter: updatedCounter));
      emit(state.copyWith(counter: updatedCounter,setCounter: true));
      _addMessage("Başarıyla eklendi", emit);
    }
  }


  Future<void> updateLastCounter(Emitter<CounterDetailState>emit)async{
    final counter = state.counter;
    if(counter!=null && counter.id!=null){
      final lastCounter = state.counterUnLimited;
      final updatedCounter = counter.copyWith(lastCounter: lastCounter);
      await _counterRepo.updateCounter(updatedCounter);
      emit(state.copyWith(counter: updatedCounter,setCounter: true));
    }else if(counter == null){
      await _sharedPreferences.setInt(PrefConstants.defaultLastCounter.key,
          state.counterUnLimited);
    }

  }

  void _vibrateEachTour()async{
    final eachTour = _sharedPreferences.getBool(PrefConstants.eachEndOfTourVibration.key)??
        PrefConstants.eachEndOfTourVibration.defaultValue;
    if(eachTour && state.hasVibrator){
      Vibration.vibrate(duration: 250);
    }
  }

  void _vibrateEachDhikr()async{
    final eachDhikr = _sharedPreferences.getBool(PrefConstants.eachDhikrVibration.key)??
        PrefConstants.eachDhikrVibration.defaultValue;
    if(eachDhikr && state.hasVibrator){
      Vibration.vibrate(duration: 30);
    }
  }

  void _addMessage(String message,Emitter<CounterDetailState>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true));
  }
}