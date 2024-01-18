

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/features/dhikr_prayers/counters/data/mapper/prayer_dhikr_mapper.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';

import 'select_dhikr_event.dart';
import 'select_dhikr_state.dart';

class SelectDhikrCounterBloc extends Bloc<ISelectDhikrEvent,SelectDhikrState>{

  late final PrayerRepo _prayerRepo;
  late final AppPreferences _appPreferences;

  SelectDhikrCounterBloc({
    required PrayerRepo prayerRepo,
    required AppPreferences appPreferences
  }) : super(SelectDhikrState.init()){
    _prayerRepo = prayerRepo;
    _appPreferences = appPreferences;

    on<SelectDhikrEventLoadData>(_onLoadData, transformer: restartable());
    on<SelectDhikrEventSelectItem>(_onSelectItem,transformer: restartable());
    on<SelectDhikrEventShowDetails>(_onShowDetails,transformer: restartable());

  }

  void _onLoadData(SelectDhikrEventLoadData event,Emitter<SelectDhikrState>emit)async{
    final showDetails = _appPreferences.getItem(KPref.selectDhikrShowDetails);

    emit(state.copyWith(
      isLoading: true,
      selectedItem: null,
      showDetails: showDetails
    ));
    final items = await _prayerRepo.getPrayerDhikrs();
    emit(state.copyWith(isLoading: false, items: items));
  }

  void _onShowDetails(SelectDhikrEventShowDetails event,Emitter<SelectDhikrState>emit)async{
    await _appPreferences.setItem(KPref.selectDhikrShowDetails, event.showDetails);
    emit(state.copyWith(showDetails: event.showDetails));
  }

  void _onSelectItem(SelectDhikrEventSelectItem event,Emitter<SelectDhikrState>emit){
    emit(state.copyWith(selectedItem: event.prayer));
  }

}