import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/search_repo.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/search_/domain/model/history.dart';
import 'package:hadith/features/search_/domain/repo/history_repo.dart';
import 'package:hadith/features/search_/presentation/bloc/search_event.dart';
import 'package:hadith/features/search_/presentation/bloc/search_state.dart';
import 'package:hadith/features/search_/presentation/model/query_criteria_model.dart';
import 'package:hadith/features/search_/presentation/model/search_result.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<ISearchEvent,SearchState>{

  late final SearchRepo _searchRepo;
  late final HistoryRepo _historyRepo;
  late final AppPreferences _appPreferences;

  final BehaviorSubject<String> _queryFilter = BehaviorSubject();

  SearchBloc({
    required SearchRepo searchRepo,
    required HistoryRepo historyRepo,
    required AppPreferences appPreferences
  }) : super(SearchState.init()){

    _searchRepo = searchRepo;
    _historyRepo = historyRepo;
    _appPreferences = appPreferences;

    on<SearchEventListenHistories>(_onListenHistories, transformer: restartable());
    on<SearchEventListenSearchResult>(_onListenSearchResult, transformer: restartable());
    on<SearchEventSearch>(_onSearch, transformer: restartable());
    on<SearchEventClearHistories>(_onClearHistories, transformer: restartable());
    on<SearchEventDeleteHistory>(_onDeleteHistory, transformer: restartable());
    on<SearchEventSetInit>(_onSetInit, transformer: restartable());

    add(SearchEventListenHistories());
    add(SearchEventListenSearchResult());
  }

  

  void _onSearch(SearchEventSearch event, Emitter<SearchState> emit)async{
    final query = event.searchKey.trim();

    final status = query.isEmpty ? DataStatus.success : DataStatus.loading;
    emit(state.copyWith(searchStatus: status));

    _queryFilter.value = query;

    if(query.isNotEmpty){
      await _historyRepo.insertOrUpdateHistory(query);
    }
  }

  void _onSetInit(SearchEventSetInit event, Emitter<SearchState> emit)async{
    final isSearchActive = state.isSearchActive;
    emit(state.copyWith(isSearchActive: false));
    emit(state.copyWith(isSearchActive: isSearchActive));
  }

  void _onClearHistories(SearchEventClearHistories event, Emitter<SearchState> emit)async{
    await _historyRepo.deleteHistories(state.histories);
  }
  
  void _onDeleteHistory(SearchEventDeleteHistory event, Emitter<SearchState> emit)async{
    await _historyRepo.deleteHistory(event.history);
  }

  void _onListenHistories(SearchEventListenHistories event, Emitter<SearchState> emit)async{
    final streamData = _historyRepo.getStreamHistories();
    
    await emit.forEach<List<History>>(streamData, onData: (histories){
      return state.copyWith(histories: histories);
    });
  }

  void _onListenSearchResult(SearchEventListenSearchResult event, Emitter<SearchState> emit)async{
    final appPrefStream = _appPreferences.listenerFiltered([KPref.searchCriteriaEnum],
        initValue: KPref.searchCriteriaEnum);

    final Stream<List<SearchResult>> streamData = Rx.combineLatest2(appPrefStream, _queryFilter, (key, query){
      final criteria = _appPreferences.getEnumItem(KPref.searchCriteriaEnum);

      emit(state.copyWith(searchStatus: DataStatus.loading,searchCriteriaEnum: criteria));

      return QueryCriteriaModel(criteria: criteria, query: query);
    }).asyncMap((queryCriteria)async{
      if(queryCriteria.query.isEmpty) return <SearchResult>[];
      return _getSearchResult(queryCriteria.query, queryCriteria.criteria);
    });

    await emit.forEach<List<SearchResult>>(streamData, onData: (searchResult){
      return state.copyWith(
        searchResults: searchResult,
        searchedKey: _queryFilter.value,
        searchStatus: DataStatus.success,
        isSearchActive: _queryFilter.value.isNotEmpty,
      );
    });
  }


  Future<List<SearchResult>> _getSearchResult(String searchedQuery, SearchCriteriaEnum criteria)async{

    final searchResults = <SearchResult>[];

    final verseCount = await _searchRepo.getCountVerse(searchedQuery, criteria);
    if(verseCount!=0){
      searchResults.add(
          SearchResult(
              title: "Ayetler",
              resultCount: verseCount,
              bookScope: BookScopeEnum.diyanetMeal
          )
      );
    }


    final allHadithCount = await _searchRepo.getCountAllHadith(searchedQuery, criteria);
    if(allHadithCount!=0){
      searchResults.add(
          SearchResult(
              title: "Tüm Hadisler",
              resultCount: allHadithCount,
              bookScope: BookScopeEnum.serlevhaSitte
          )
      );
    }

    final serlevhaCount = await _searchRepo.getCountHadithByBookId(searchedQuery, criteria, BookEnum.serlevha.bookId);
    if(serlevhaCount!=0){
      searchResults.add(
          SearchResult(
              title: "Serlevha Hadis",
              resultCount: serlevhaCount,
              bookScope: BookScopeEnum.serlevha
          )
      );
    }

    final sitteCount = await _searchRepo.getCountHadithByBookId(searchedQuery, criteria, BookEnum.sitte.bookId);

    if(sitteCount!=0){
      searchResults.add(
          SearchResult(
              title: "Kütübi Sitte Hadis",
              resultCount: sitteCount,
              bookScope: BookScopeEnum.sitte
          )
      );
    }

    return searchResults;
  }


}

