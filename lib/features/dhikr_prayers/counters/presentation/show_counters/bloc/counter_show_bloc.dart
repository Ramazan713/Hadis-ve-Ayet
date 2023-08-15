

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';

import 'counter_show_event.dart';
import 'counter_show_state.dart';

class CounterShowBloc extends Bloc<ICounterShowEvent,CounterShowState>{
  late final CounterRepo _counterRepo;

  CounterShowBloc({
    required CounterRepo counterRepo
  }) : super(CounterShowState.init()){

    _counterRepo = counterRepo;

    on<CounterShowEventInit>(_onInit);
    on<CounterShowEventDelete>(_onDelete,transformer: droppable());

    add(CounterShowEventInit());
  }


  void _onInit(CounterShowEventInit event,Emitter<CounterShowState>emit)async{
    final streamData = _counterRepo.getStreamCounters();
    await emit.forEach<List<Counter>>(streamData, onData: (data)=> state.copyWith(counters: data));

  }
  void _onDelete(CounterShowEventDelete event,Emitter<CounterShowState>emit)async{
    await _counterRepo.deleteCounter(event.counter);
  }
}