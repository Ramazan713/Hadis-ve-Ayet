

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/data/mapper/prayer_dhikr_mapper.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';

import 'add_counter_event.dart';
import 'add_counter_state.dart';

class AddCounterBloc extends Bloc<IAddCounterEvent,AddCounterState>{
  late final CounterRepo _counterRepo;
  late final PrayerRepo _prayerRepo;

  AddCounterBloc({
    required CounterRepo counterRepo,
    required PrayerRepo prayerRepo
  }) : super(AddCounterState.init()){

    _counterRepo = counterRepo;
    _prayerRepo = prayerRepo;

    on<AddCounterEventLoadData>(_onLoadData);
    on<AddCounterEventAddCounter>(_onAddCounter,transformer: droppable());
    on<AddCounterEventClearMessage>(_onClearMessage,transformer: restartable());
    on<AddCounterEventClearNavigateBack>(_onClearNavigateBack,transformer: restartable());

    add(AddCounterEventLoadData());
  }

  void _onLoadData(AddCounterEventLoadData event,Emitter<AddCounterState>emit)async{
    emit(state.copyWith(isLoading: true));
    final items = await _prayerRepo.getPrayerDhikrs();
    emit(state.copyWith(isLoading: false,items: items));
  }

  void _onAddCounter(AddCounterEventAddCounter event,Emitter<AddCounterState>emit)async{
    final newCounter = event.prayer.toCounter();
    await _counterRepo.insertCounter(newCounter);
    emit(state.copyWith(
      message: "Başarıyla kaydedildi",
      navigateBack: true
    ));
  }


  void _onClearMessage(AddCounterEventClearMessage event,Emitter<AddCounterState>emit){
    emit(state.copyWith(message: null));
  }
  void _onClearNavigateBack(AddCounterEventClearNavigateBack event,Emitter<AddCounterState>emit){
    emit(state.copyWith(navigateBack: false));
  }

}