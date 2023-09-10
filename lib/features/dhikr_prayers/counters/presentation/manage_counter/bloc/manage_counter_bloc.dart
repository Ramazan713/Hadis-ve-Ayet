

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';
import 'manage_counter_event.dart';
import 'manage_counter_state.dart';

class ManageCounterBloc extends Bloc<IManageCounterEvent,ManageCounterState>{

  late final CounterRepo _counterRepo;

  ManageCounterBloc({
    required CounterRepo counterRepo,
  }) : super(ManageCounterState.init()){

    _counterRepo = counterRepo;

    on<ManageCounterEventUpdate>(_onUpdate,transformer: droppable());
    on<ManageCounterEventLoadData>(_onLoadData,transformer: droppable());

    on<ManageCounterEventSetType>(_onSetType,transformer: restartable());

    on<ManageCounterEventClearNavigateBack>(_onClearNavigateBack,transformer: restartable());
    on<ManageCounterEventClearMessage>(_onClearMessage,transformer: restartable());
  }

  void _onLoadData(ManageCounterEventLoadData event,Emitter<ManageCounterState>emit)async{
    emit(ManageCounterState.init().copyWith(isLoading: true));
    final counter = await _counterRepo.getCounterById(event.counterId??0);

    emit(state.copyWith(
      isLoading: false,
      currentCounter: counter,
      selectedType: counter?.counterType ?? state.selectedType
    ));
  }

  void _onUpdate(ManageCounterEventUpdate event,Emitter<ManageCounterState>emit)async{
    final currentCounter = state.currentCounter;
    final name = event.newName.trim();
    final content = event.newContent?.trim();
    final arabicContent = event.newArabicContent?.trim();
    final meaning = event.newMeaning?.trim();
    final description = event.description?.trim();
    final selectedType = state.selectedType;
    final goalStr = event.newGoal;
    final goal = int.tryParse(goalStr??"");

    if(name.isEmpty){
      return emit(state.copyWith(message: "isim alanı boş geçilemez"));
    }
    if(goalStr!=null && goalStr != "" && goal==null){
      return emit(state.copyWith(message: "lütfen hedef alanı için geçerli bir değer giriniz"));
    }else if(goal != null && goal <= 0){
      return emit(state.copyWith(message: "hedef değeri 1 dan küçük olamaz"));
    }

    final newCounter = Counter(
      name: name,
      counterType: selectedType,
      lastCounter: currentCounter?.lastCounter ?? 0,
      arabicContent: arabicContent,
      order: currentCounter?.order ?? 0,
      id: currentCounter?.id,
      goal: goal,
      content: content,
      description: description,
      meaning: meaning,
      prayerId: currentCounter?.prayerId
    );

    if(currentCounter != null){
      await _counterRepo.updateCounter(newCounter);
    }else{
      await _counterRepo.insertCounter(newCounter);
    }

    emit(state.copyWith(
      message: "Başarılı",
      navigateBack: true
    ));
  }

  void _onClearMessage(ManageCounterEventClearMessage event,Emitter<ManageCounterState>emit){
    emit(state.copyWith(message: null));
  }

  void _onClearNavigateBack(ManageCounterEventClearNavigateBack event,Emitter<ManageCounterState>emit){
    emit(state.copyWith(navigateBack: false));
  }

  void _onSetType(ManageCounterEventSetType event,Emitter<ManageCounterState>emit)async{
    emit(state.copyWith(selectedType: event.type));
  }
}











