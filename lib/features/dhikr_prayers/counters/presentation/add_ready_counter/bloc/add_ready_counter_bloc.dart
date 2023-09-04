

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/features/dhikr_prayers/counters/data/mapper/prayer_dhikr_mapper.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';

import 'add_ready_counter_event.dart';
import 'add_ready_counter_state.dart';

class AddReadyCounterBloc extends Bloc<IAddReadyCounterEvent,AddReadyCounterState>{

  late final CounterRepo _counterRepo;
  late final PrayerRepo _prayerRepo;
  late final AppPreferences _appPreferences;

  AddReadyCounterBloc({
    required CounterRepo counterRepo,
    required PrayerRepo prayerRepo,
    required AppPreferences appPreferences
  }) : super(AddReadyCounterState.init()){

    _counterRepo = counterRepo;
    _prayerRepo = prayerRepo;
    _appPreferences = appPreferences;

    on<AddReadyCounterEventLoadData>(_onLoadData, transformer: restartable());
    on<AddReadyCounterEventAddCounter>(_onAddCounter,transformer: droppable());
    on<AddReadyCounterEventSelectItem>(_onSelectItem,transformer: restartable());
    on<AddReadyCounterEventShowDetails>(_onShowDetails,transformer: restartable());

    on<AddReadyCounterEventClearMessage>(_onClearMessage,transformer: restartable());
    on<AddReadyCounterEventClearNavigateBack>(_onClearNavigateBack,transformer: restartable());
  }

  void _onLoadData(AddReadyCounterEventLoadData event,Emitter<AddReadyCounterState>emit)async{
    final showDetails = _appPreferences.getItem(KPref.addCounterShowDetails);

    emit(state.copyWith(
      isLoading: true,
      selectedItem: null,
      showDetails: showDetails
    ));
    final items = await _prayerRepo.getPrayerDhikrs();
    emit(state.copyWith(isLoading: false, items: items));
  }

  void _onAddCounter(AddReadyCounterEventAddCounter event,Emitter<AddReadyCounterState>emit)async{
    final newCounter = event.prayer.toCounter();
    await _counterRepo.insertCounter(newCounter);
    emit(state.copyWith(
      message: "Başarıyla kaydedildi",
      navigateBack: true
    ));
  }

  void _onShowDetails(AddReadyCounterEventShowDetails event,Emitter<AddReadyCounterState>emit)async{
    await _appPreferences.setItem(KPref.addCounterShowDetails, event.showDetails);
    emit(state.copyWith(showDetails: event.showDetails));
  }

  void _onSelectItem(AddReadyCounterEventSelectItem event,Emitter<AddReadyCounterState>emit){
    emit(state.copyWith(selectedItem: event.prayer));
  }


  void _onClearMessage(AddReadyCounterEventClearMessage event,Emitter<AddReadyCounterState>emit){
    emit(state.copyWith(message: null));
  }
  void _onClearNavigateBack(AddReadyCounterEventClearNavigateBack event,Emitter<AddReadyCounterState>emit){
    emit(state.copyWith(navigateBack: false));
  }

}