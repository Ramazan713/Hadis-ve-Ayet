

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';

import 'counter_show_event.dart';
import 'counter_show_state.dart';

class CounterShowBloc extends Bloc<ICounterShowEvent,CounterShowState>{
  late final CounterRepo _counterRepo;
  late final AppPreferences _appPreferences;

  CounterShowBloc({
    required CounterRepo counterRepo,
    required AppPreferences appPreferences
  }) : super(CounterShowState.init()){

    _counterRepo = counterRepo;
    _appPreferences = appPreferences;

    on<CounterShowEventInit>(_onInit);
    on<CounterShowEventLoadData>(_onLoadData, transformer: restartable());
    on<CounterShowEventSetDetailView>(_onSetDetailView, transformer: restartable());
    on<CounterShowEventDelete>(_onDelete,transformer: droppable());

    add(CounterShowEventInit());
  }

  void _onLoadData(CounterShowEventLoadData event,Emitter<CounterShowState>emit){
    final showDetail = _appPreferences.getItem(KPref.showCounterDetailContents);
    emit(state.copyWith(showDetailContents: showDetail));
  }

  void _onInit(CounterShowEventInit event,Emitter<CounterShowState>emit)async{
    final streamData = _counterRepo.getStreamCounters();
    await emit.forEach<List<Counter>>(streamData, onData: (data)=> state.copyWith(counters: data));

  }
  void _onDelete(CounterShowEventDelete event,Emitter<CounterShowState>emit)async{
    await _counterRepo.deleteCounter(event.counter);
  }

  void _onSetDetailView(CounterShowEventSetDetailView event,Emitter<CounterShowState>emit)async{
    await _appPreferences.setItem(KPref.showCounterDetailContents, event.showDetail);
    emit(state.copyWith(showDetailContents: event.showDetail));
  }
}