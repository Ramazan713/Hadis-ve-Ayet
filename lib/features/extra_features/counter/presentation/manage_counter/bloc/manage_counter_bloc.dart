

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';
import 'package:hadith/features/extra_features/counter/domain/repo/counter_repo.dart';
import 'package:hadith/features/extra_features/counter/domain/use_case/insert_counter_use_case.dart';

import 'manage_counter_event.dart';
import 'manage_counter_state.dart';

class ManageCounterBloc extends Bloc<IManageCounterEvent,ManageCounterState>{

  late final CounterRepo _counterRepo;
  late final InsertCounterUseCase _insertCounterUseCase;

  ManageCounterBloc({required CounterRepo counterRepo,required InsertCounterUseCase insertCounterUseCase}) : super(ManageCounterState.init()){
    _counterRepo = counterRepo;
    _insertCounterUseCase = insertCounterUseCase;

    on<ManageCounterEventUpdate>(_onUpdate,transformer: droppable());
    on<ManageCounterEventSetType>(_onSetType,transformer: droppable());
  }

  void _addMessage(String message,Emitter<ManageCounterState>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true));
  }

  void _onSetType(ManageCounterEventSetType event,Emitter<ManageCounterState>emit)async{
    emit(state.copyWith(type: event.type));
  }

  void _onUpdate(ManageCounterEventUpdate event,Emitter<ManageCounterState>emit)async{
    final Counter? counter = event.counter;
    final hasInserted = counter != null;
    final name = event.newName.trim();
    final content = event.newContent?.trim();
    final arabicContent = event.newArabicContent?.trim();
    final meaning = event.newMeaning?.trim();
    final type = state.type;
    final goalStr = event.newGoal;

    if(name.isEmpty){
      return _addMessage("isim alanı boş geçilemez", emit);
    }
    if(goalStr!=null && goalStr != "" && int.tryParse(goalStr)==null){
      return _addMessage("lütfen hedef alanı için geçerli bir değer giriniz", emit);
    }
    final goal = int.tryParse(goalStr??"");
    if(hasInserted){
      final updateCounter = counter.copyWith(
        name: name,
        goal: goal, setGoal: true,
        content: content, setContent: true,
        arabicContent: arabicContent, setArabicContent: true,
        meaning: meaning, setMeaning: true,
        counterType: type,
      );
      await _counterRepo.updateCounter(updateCounter);
    }else{
      await _insertCounterUseCase.operator(
          name: name, counterType: type,content: content,arabicContent: arabicContent,
          goal: goal, lastCounter: 0, meaning: meaning
      );
    }
    _addMessage("Başarılı", emit);
    emit(state.copyWith(navigatePop: true));
    emit(state.copyWith(navigatePop: false));
  }
}











