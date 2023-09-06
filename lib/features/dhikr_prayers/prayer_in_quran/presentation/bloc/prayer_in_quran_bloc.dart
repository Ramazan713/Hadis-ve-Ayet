

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';

import 'prayer_in_quran_event.dart';
import 'prayer_in_quran_state.dart';
import 'package:rxdart/rxdart.dart';

class PrayerInQuranBloc extends Bloc<IPrayerInQuranEvent,PrayerInQuranState>{

  late final PrayerRepo _prayerRepo;
  late final AppPreferences _appPreferences;
  late final FontModelUseCase _fontModelUseCase;

  final BehaviorSubject<String> _filterQuery = BehaviorSubject();
  final BehaviorSubject<SearchCriteriaEnum> _filterCriteria = BehaviorSubject();


  PrayerInQuranBloc({
    required PrayerRepo prayerRepo,
    required AppPreferences appPreferences,
    required FontModelUseCase fontModelUseCase
  }): super(PrayerInQuranState.init()){

    _prayerRepo = prayerRepo;
    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;

    _filterQuery.value = "";
    _filterCriteria.value = _appPreferences.getEnumItem(KPref.prayerInQuranSearchCriteria);

    on<PrayerInQuranEventListenAppPref>(_onListenAppPref,transformer: restartable());
    on<PrayerInQuranEventListenData>(_onListenData,transformer: restartable());
    on<PrayerInQuranEventSetQuery>(_onSetQuery,transformer: restartable());
    on<PrayerInQuranEventSetSearchBarVisibility>(_onSetSearchBarVisibility,transformer: restartable());
    on<PrayerInQuranEventClearMessage>(_onClearMessage,transformer: restartable());
    on<PrayerInQuranEventAddCustomPrayer>(_onAddCustomPrayer,transformer: restartable());

    add(PrayerInQuranEventListenAppPref());
    add(PrayerInQuranEventListenData());
  }

  void _onListenData(PrayerInQuranEventListenData event,Emitter<PrayerInQuranState>emit)async{

    final streamData = Rx.combineLatest2(_filterQuery, _filterCriteria, (query, criteria){
      return _QueryCriteria(query: query,criteriaEnum: criteria);
    }).switchMap((queryCriteria){
      if(queryCriteria.query.trim().isEmpty) return _prayerRepo.getStreamPrayerInQurans();
      return _prayerRepo.getSearchedPrayersInQuran(queryCriteria.query.trim(), queryCriteria.criteriaEnum);
    });

    await emit.forEach<List<PrayerInQuran>>(streamData, onData: (data){
      return state.copyWith(items: data);
    });
  }

  void _onSetQuery(PrayerInQuranEventSetQuery event,Emitter<PrayerInQuranState>emit)async{
    emit(state.copyWith(searchQuery: event.query.trim()));
    EasyDebounce.debounce("prayer_in_quran_search", const Duration(milliseconds: 300), () {
      _filterQuery.value = event.query.trim();
    });
  }

  void _onSetSearchBarVisibility(PrayerInQuranEventSetSearchBarVisibility event,Emitter<PrayerInQuranState>emit)async{
    emit(state.copyWith(isSearchBarVisible: event.isVisible));
  }

  void _onClearMessage(PrayerInQuranEventClearMessage event,Emitter<PrayerInQuranState>emit)async{
    emit(state.copyWith(message: null));
  }

  void _onAddCustomPrayer(PrayerInQuranEventAddCustomPrayer event,Emitter<PrayerInQuranState>emit)async{
    _prayerRepo.insertCustomPrayerWithRelationForPrayerQuran(event.prayer);
    emit(state.copyWith(message: "Başarıyla Eklendi"));
  }

  void _onListenAppPref(PrayerInQuranEventListenAppPref event,Emitter<PrayerInQuranState>emit)async{
    final streamData = _appPreferences.listenerFiltered([
      KPref.fontSizeContent,
      KPref.fontFamilyArabic,
      KPref.fontSizeArabic,
      KPref.prayerInQuranSearchCriteria,
      KPref.quranPrayerVerseUi
    ], initValue: null);

    emit(state.copyWith(
        fontModel: _fontModelUseCase(),
        arabicVerseUI2X: _appPreferences.getEnumItem(KPref.quranPrayerVerseUi)
    ));

    await emit.forEach(streamData, onData: (key){
      final criteria = _appPreferences.getEnumItem(KPref.prayerInQuranSearchCriteria);
      final verseUi = _appPreferences.getEnumItem(KPref.quranPrayerVerseUi);
      return state.copyWith(
        arabicVerseUI2X: verseUi,
        searchCriteria: criteria,
        fontModel: _fontModelUseCase(),
      );
    });
  }

  
}

class _QueryCriteria extends Equatable{
  final String query;
  final SearchCriteriaEnum criteriaEnum;

  const _QueryCriteria({required this.query, required this.criteriaEnum});

  @override
  List<Object?> get props => [query, criteriaEnum];
}