

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/counter/domain/use_case/insert_counter_use_case.dart';

import '../../../domain/repo/counter_repo.dart';
import 'add_counter_event.dart';
import 'add_counter_state.dart';

class AddCounterBloc extends Bloc<IAddCounterEvent,AddCounterState>{
  late final CounterRepo _counterRepo;
  late final InsertCounterUseCase _insertCounterUseCase;

  AddCounterBloc({required CounterRepo counterRepo,required InsertCounterUseCase insertCounterUseCase}) : super(AddCounterState.init()){
    _counterRepo = counterRepo;
    _insertCounterUseCase = insertCounterUseCase;

    on<AddCounterEventInit>(_onInit);
    on<AddCounterEventAddCounter>(_onAddCounter,transformer: droppable());

    add(AddCounterEventInit());

  }

  void _onInit(AddCounterEventInit event,Emitter<AddCounterState>emit)async{
    emit(state.copyWith(isLoading: true));
    final items = await _counterRepo.getNonRemovableCounters();
    emit(state.copyWith(isLoading: false,counters: items));
  }

  void _onAddCounter(AddCounterEventAddCounter event,Emitter<AddCounterState>emit)async{
    final counter = event.counter;
    await _insertCounterUseCase.operator(
        name: counter.name,
        counterType: counter.counterType,
        lastCounter: 0,
        meaning: counter.meaning,
        content: counter.content,
        arabicContent: counter.arabicContent
    );

    emit(state.copyWith(message: "Kaydedildi",setMessage: true,navigationPop: true));
    emit(state.copyWith(setMessage: true,navigationPop: false));

  }


}