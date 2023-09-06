

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/local/services/prayer_dao.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/features/dhikr_prayers/counters/data/mapper/counter_mapper.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_mapper.dart';

import 'counter_show_event.dart';
import 'counter_show_state.dart';

class CounterShowBloc extends Bloc<ICounterShowEvent,CounterShowState>{
  late final CounterRepo _counterRepo;
  late final PrayerDao _prayerDao;
  late final AppPreferences _appPreferences;

  CounterShowBloc({
    required CounterRepo counterRepo,
    required PrayerDao prayerDao,
    required AppPreferences appPreferences
  }) : super(CounterShowState.init()){

    _counterRepo = counterRepo;
    _appPreferences = appPreferences;
    _prayerDao = prayerDao;

    on<CounterShowEventInit>(_onInit);
    on<CounterShowEventLoadData>(_onLoadData, transformer: restartable());
    on<CounterShowEventAddToCustomPrayer>(_onAddToCustomPrayer, transformer: restartable());
    on<CounterShowEventSetDetailView>(_onSetDetailView, transformer: restartable());
    on<CounterShowEventDelete>(_onDelete,transformer: droppable());
    on<CounterShowEventClearMessage>(_onClearMessage,transformer: droppable());

    add(CounterShowEventInit());
  }

  void _onLoadData(CounterShowEventLoadData event,Emitter<CounterShowState>emit){
    final showDetail = _appPreferences.getItem(KPref.showCounterDetailContents);
    emit(state.copyWith(showDetailContents: showDetail));
  }

  void _onAddToCustomPrayer(CounterShowEventAddToCustomPrayer event,Emitter<CounterShowState>emit)async{
    final prayer = event.counter.toPrayer();
    await _prayerDao.insertPrayerWithOrder(prayer.toPrayerEntity());
    emit(state.copyWith(message: "Başarıyla Eklendi"));
  }

  void _onInit(CounterShowEventInit event,Emitter<CounterShowState>emit)async{
    final streamData = _counterRepo.getStreamCounters();
    await emit.forEach<List<Counter>>(streamData, onData: (data)=> state.copyWith(counters: data));

  }
  void _onDelete(CounterShowEventDelete event,Emitter<CounterShowState>emit)async{
    await _counterRepo.deleteCounter(event.counter);
    emit(state.copyWith(message: "Başarıyla Silindi"));
  }

  void _onSetDetailView(CounterShowEventSetDetailView event,Emitter<CounterShowState>emit)async{
    await _appPreferences.setItem(KPref.showCounterDetailContents, event.showDetail);
    emit(state.copyWith(showDetailContents: event.showDetail));
  }

  void _onClearMessage(CounterShowEventClearMessage event,Emitter<CounterShowState>emit){
    emit(state.copyWith(message: null));
  }
}