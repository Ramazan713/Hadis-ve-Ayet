

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/counter.dart';
import '../../../domain/repo/counter_repo.dart';
import 'counter_show_event.dart';
import 'counter_show_state.dart';

class CounterShowBlocOld extends Bloc<ICounterShowEventOld,CounterShowStateOld>{
  late final CounterRepoOld _counterRepo;

  CounterShowBlocOld({required CounterRepoOld counterRepo}) : super(CounterShowStateOld.init()){
    _counterRepo = counterRepo;

    on<CounterShowEventInit>(_onInit);
    on<CounterShowEventDelete>(_onDelete,transformer: droppable());

    add(CounterShowEventInit());
  }


  void _onInit(CounterShowEventInit event,Emitter<CounterShowStateOld>emit)async{
    final streamData = _counterRepo.getStreamRemovableCounters();

    await emit.forEach<List<Counter>>(streamData, onData: (data)=> state.copyWith(counters: data));

  }
  void _onDelete(CounterShowEventDelete event,Emitter<CounterShowStateOld>emit)async{
    await _counterRepo.deleteCounter(event.counter);
  }
}