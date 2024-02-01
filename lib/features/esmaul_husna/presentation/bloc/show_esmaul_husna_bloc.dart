

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/domain/repo/esmaul_husna_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'show_esmaul_husna_event.dart';
import 'show_esmaul_husna_state.dart';

class ShowEsmaulHusnaBloc extends Bloc<IShowEsmaulHusnaEvent,ShowEsmaulHusnaState>{

  late final EsmaulHusnaRepo _esmaulHusnaRepo;
  late final AppPreferences _appPreferences;
  late final FontModelUseCase _fontModelUseCase;

  final BehaviorSubject<String> _filterQuery = BehaviorSubject();
  final BehaviorSubject<SearchCriteriaEnum> _filterCriteria = BehaviorSubject();


  ShowEsmaulHusnaBloc({
    required EsmaulHusnaRepo esmaulHusnaRepo,
    required AppPreferences appPreferences,
    required FontModelUseCase fontModelUseCase
  }): super(ShowEsmaulHusnaState.init()){

    _esmaulHusnaRepo = esmaulHusnaRepo;
    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;

    _filterQuery.value = "";
    _filterCriteria.value = _appPreferences.getEnumItem(KPref.esmaulHusnaSearchCriteria);
    
    on<ShowEsmaulHusnaEventListenAppPref>(_onListenAppPref,transformer: restartable());
    on<ShowEsmaulHusnaEventListenData>(_onListenData,transformer: restartable());

    on<ShowEsmaulHusnaEventSetQuery>(_onSetQuery,transformer: restartable());
    on<ShowEsmaulHusnaEventSetSearchBarVisibility>(_onSetSearchBarVisibility,transformer: restartable());
    on<ShowEsmaulHusnaEventClearMessage>(_onClearMessage,transformer: restartable());
    on<ShowEsmaulHusnaEventHideDetail>(_onHideDetail,transformer: restartable());
    on<ShowEsmaulHusnaEventShowDetail>(_onShowDetail,transformer: sequential());
    on<ShowEsmaulHusnaEventSaveAsDhikr>(_onSaveAsDhikr,transformer: droppable());
    on<ShowEsmaulHusnaEventReStartState>(_onReStartState,transformer: sequential());
    on<ShowEsmaulHusnaEventSetSelected>(_onSetSelected,transformer: sequential());


    add(ShowEsmaulHusnaEventListenAppPref());
    add(ShowEsmaulHusnaEventListenData());
  }


  void _onListenData(ShowEsmaulHusnaEventListenData event,Emitter<ShowEsmaulHusnaState>emit)async{
    final streamFilter = Rx.combineLatest2(_filterQuery, _filterCriteria, (query, criteria){
      return _QueryCriteria(query: query,criteriaEnum: criteria);
    });

    final streamData = streamFilter.switchMap((queryCriteria){
      if(queryCriteria.query.trim().isEmpty) {
        return _esmaulHusnaRepo.getStreamEsmaulHusnas();
      }
      return _esmaulHusnaRepo.getStreamSearchedEsmaulHusnas(queryCriteria.query.trim(), queryCriteria.criteriaEnum);
    });

    await emit.forEach<List<EsmaulHusna>>(streamData, onData: (data){
      return state.copyWith(items: data,isLoading: false);
    });

  }

  void _onSetQuery(ShowEsmaulHusnaEventSetQuery event,Emitter<ShowEsmaulHusnaState>emit)async{
    emit(state.copyWith(searchQuery: event.query.trim()));
    EasyDebounce.debounce("esmaul_husna_search", const Duration(milliseconds: 300), () {
      _filterQuery.value = event.query.trim();
    });
  }

  void _onSetSearchBarVisibility(ShowEsmaulHusnaEventSetSearchBarVisibility event,Emitter<ShowEsmaulHusnaState>emit)async{
    emit(state.copyWith(isSearchBarVisible: event.isVisible));
  }

  void _onReStartState(ShowEsmaulHusnaEventReStartState event,Emitter<ShowEsmaulHusnaState>emit){
    emit(state.copyWith(isDetailOpen: false, selectedItem: null));
  }

  void _onSetSelected(ShowEsmaulHusnaEventSetSelected event,Emitter<ShowEsmaulHusnaState>emit){
    emit(state.copyWith(selectedItem: event.item));
  }

  void _onHideDetail(ShowEsmaulHusnaEventHideDetail event,Emitter<ShowEsmaulHusnaState>emit){
    emit(state.copyWith(selectedItem: null, isDetailOpen: false));
  }

  void _onShowDetail(ShowEsmaulHusnaEventShowDetail event,Emitter<ShowEsmaulHusnaState>emit){
    emit(state.copyWith(selectedItem: event.item, isDetailOpen: true));
  }


  void _onClearMessage(ShowEsmaulHusnaEventClearMessage event,Emitter<ShowEsmaulHusnaState>emit)async{
    emit(state.copyWith());
  }

  void _onListenAppPref(ShowEsmaulHusnaEventListenAppPref event,Emitter<ShowEsmaulHusnaState>emit)async{
    final streamData = _appPreferences.listenerFiltered([
      KPref.fontSizeContent,
      KPref.fontFamilyArabic,
      KPref.fontSizeArabic,
      KPref.esmaulHusnaSearchCriteria,
    ], initValue: null);

    emit(state.copyWith(
        fontModel: _fontModelUseCase(),
    ));

    await emit.forEach(streamData, onData: (key){
      final criteria = _appPreferences.getEnumItem(KPref.esmaulHusnaSearchCriteria);
      return state.copyWith(
        searchCriteria: criteria,
        fontModel: _fontModelUseCase(),
      );
    });
  }

  void _onSaveAsDhikr(ShowEsmaulHusnaEventSaveAsDhikr event,Emitter<ShowEsmaulHusnaState>emit)async{
    await _esmaulHusnaRepo.addCounterFromEsmaulHusna(event.item);
    emit(state.copyWith(message: "Başarıyla kaydedildi"));
  }
  
}

class _QueryCriteria extends Equatable{
  final String query;
  final SearchCriteriaEnum criteriaEnum;

  const _QueryCriteria({required this.query, required this.criteriaEnum});

  @override
  List<Object?> get props => [query, criteriaEnum];
}