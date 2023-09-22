

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'show_custom_prayers_event.dart';
import 'show_custom_prayers_state.dart';

class ShowCustomPrayersBloc extends Bloc<IShowCustomPrayersEvent,ShowCustomPrayersState>{

  late final AppPreferences _appPreferences;
  late final PrayerCustomRepo _prayerRepo;

  final BehaviorSubject<String> _filterQuery = BehaviorSubject();

  ShowCustomPrayersBloc({
    required PrayerCustomRepo prayerRepo,
    required AppPreferences appPreferences,
  }): super(ShowCustomPrayersState.init()){

    _appPreferences = appPreferences;
    _prayerRepo = prayerRepo;

    _filterQuery.value = "";

    on<ShowCustomPrayersEventListenData>(_onListenData,transformer: restartable());
    on<ShowCustomPrayersEventLoadData>(_onLoadData,transformer: restartable());

    on<ShowCustomPrayersEventSetQuery>(_onSetQuery,transformer: restartable());
    on<ShowCustomPrayersEventAddDhikr>(_onAddDhikr,transformer: restartable());
    on<ShowCustomPrayersEventUpdateDhikr>(_onUpdateDhikr,transformer: restartable());
    on<ShowCustomPrayersEventDelete>(_onDelete,transformer: restartable());
    on<ShowCustomPrayersEventSetDetailView>(_onSetDetailView, transformer: restartable());


    on<ShowCustomPrayersEventSetSearchBarVisibility>(_onSetSearchBarVisibility,transformer: restartable());
    on<ShowCustomPrayersEventClearMessage>(_onClearMessage,transformer: restartable());

    add(ShowCustomPrayersEventListenData());
  }



  void _onListenData(ShowCustomPrayersEventListenData event,Emitter<ShowCustomPrayersState>emit)async{
    emit(state.copyWith(isLoading: true));

    final streamData = _filterQuery.switchMap((query){
      if(query.isEmpty) return _prayerRepo.getStreamPrayerCustoms();
      return _prayerRepo.getStreamSearchedCustomPrayers(query);
    });

    await emit.forEach<List<PrayerCustom>>(streamData, onData: (data){
      return state.copyWith(
        items: data,
        isLoading: false
      );
    });
  }

  void _onLoadData(ShowCustomPrayersEventLoadData event,Emitter<ShowCustomPrayersState>emit)async{

    final showDetails = _appPreferences.getItem(KPref.showCustomPrayersShowDetailContents);
    emit(state.copyWith(isLoading: true,showDetailContents: showDetails));
    final items = await _prayerRepo.getPrayerCustoms();
    emit(state.copyWith(
      items: items,
      isLoading: false
    ));
  }

  void _onUpdateDhikr(ShowCustomPrayersEventUpdateDhikr event,Emitter<ShowCustomPrayersState>emit)async{
    await _prayerRepo.updateToCounter(event.prayer);
    emit(state.copyWith(message: "Zikir güncellendi"));
  }

  void _onSetQuery(ShowCustomPrayersEventSetQuery event,Emitter<ShowCustomPrayersState>emit)async{
    emit(state.copyWith(searchQuery: event.query.trim()));
    EasyDebounce.debounce("custom_prayers_search", const Duration(milliseconds: 300), () {
      _filterQuery.value = event.query.trim();
    });
  }

  void _onSetDetailView(ShowCustomPrayersEventSetDetailView event,Emitter<ShowCustomPrayersState>emit)async{
    await _appPreferences.setItem(KPref.showCustomPrayersShowDetailContents, event.showDetail);
    emit(state.copyWith(showDetailContents: event.showDetail));
  }

  void _onAddDhikr(ShowCustomPrayersEventAddDhikr event,Emitter<ShowCustomPrayersState>emit)async{
    if(event.prayer.counterId != null) return;
    await _prayerRepo.addToCounter(event.prayer);
    emit(state.copyWith(
        message: "Başarıyla kaydedildi"
    ));
  }

  void _onDelete(ShowCustomPrayersEventDelete event,Emitter<ShowCustomPrayersState>emit)async{
    await _prayerRepo.deletePrayerCustom(event.prayer);
    emit(state.copyWith(
        message: "Başarıyla silindi"
    ));
  }


  void _onSetSearchBarVisibility(ShowCustomPrayersEventSetSearchBarVisibility event,Emitter<ShowCustomPrayersState>emit)async{
    emit(state.copyWith(isSearchBarVisible: event.isVisible));
  }

  void _onClearMessage(ShowCustomPrayersEventClearMessage event,Emitter<ShowCustomPrayersState>emit)async{
    emit(state.copyWith(message: null));
  }

}