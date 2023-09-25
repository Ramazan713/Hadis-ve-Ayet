import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/search_part/search_part.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/search_repo.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/utils/search_utils.dart';
import 'package:hadith/features/search/domain/model/history.dart';
import 'package:hadith/features/search/domain/repo/history_repo.dart';
import 'package:hadith/features/search/presentation/bloc/search_event.dart';
import 'package:hadith/features/search/presentation/bloc/search_state.dart';
import 'package:hadith/features/search/domain/model/query_criteria_model.dart';
import 'package:hadith/features/search/domain/model/search_content.dart';
import 'package:hadith/features/search/domain/model/search_result.dart';
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
    on<SearchEventSetQuery>(_onSetQuery, transformer: restartable());
    on<SearchEventDeleteHistory>(_onDeleteHistory, transformer: restartable());

    add(SearchEventListenHistories());
    add(SearchEventListenSearchResult());
  }

  

  void _onSearch(SearchEventSearch event, Emitter<SearchState> emit)async{
    EasyDebounce.debounce("Searching", const Duration(milliseconds: 700), () async{
      add(SearchEventSetQuery(query: event.searchKey));
    });
  }

  void _onSetQuery(SearchEventSetQuery event, Emitter<SearchState> emit)async{
    final query = event.query.trim();
    _queryFilter.value = query;
    if(query.isNotEmpty){
      await _historyRepo.insertOrUpdateHistory(query);
    }
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
      emit(state.copyWith(isLoading: true,searchCriteria: criteria));
      return QueryCriteriaModel(criteria: criteria, query: query);
    }).asyncMap((queryCriteria)async{
      if(queryCriteria.query.isEmpty) return <SearchResult>[];
      return _getSearchResult(queryCriteria.query, queryCriteria.criteria);
    });

    await emit.forEach<List<SearchResult>>(streamData, onData: (searchResult){
      return state.copyWith(
        searchResults: searchResult,
        searchQuery: _queryFilter.value,
        isLoading: false,
      );
    });
  }



  Future<List<SearchResult>> _getSearchResult(String searchedQuery, SearchCriteriaEnum criteria)async{

    final searchResults = <SearchResult>[];
    const pageSize = K.searchResultCollectionSize;

    final verseCount = await _searchRepo.getCountVerse(searchedQuery, criteria);
    if(verseCount!=0){
      final verseSamples = await _searchRepo.getVerses(searchedQuery, criteria, pageSize, 0);

      final searchContents = verseSamples.map((e) => SearchContent(
          content: e.content,
          source: "${e.surahName} - ${e.verseNumber}",
          searchParts: _getSearchParts(e.content)
      )).toList();

      searchResults.add(
        SearchResult(
            title: "Ayetler",
            resultCount: verseCount,
            searchContents: searchContents,
            bookScope: BookScopeEnum.diyanetMeal
        )
      );
    }


    final allHadithCount = await _searchRepo.getCountAllHadith(searchedQuery, criteria);
    if(allHadithCount!=0){
      final hadithSamples = await _searchRepo.getAllHadiths(searchedQuery, criteria, pageSize, 0);
      final searchContents = hadithSamples.map((e) => SearchContent(
          content: e.content,
          source: e.source,
          searchParts: _getSearchParts(e.content)
      )).toList();

      searchResults.add(
        SearchResult(
            title: "Tüm Hadisler",
            resultCount: allHadithCount,
            searchContents: searchContents,
            bookScope: BookScopeEnum.serlevhaSitte
        )
      );
    }

    final serlevhaCount = await _searchRepo.getCountHadithByBookId(searchedQuery, criteria, BookEnum.serlevha.bookId);
    if(serlevhaCount!=0){
      final hadithSamples = await _searchRepo.getHadithsByBookId(searchedQuery, criteria,BookEnum.serlevha.bookId, pageSize, 0);
      final searchContents = hadithSamples.map((e) => SearchContent(
          content: e.content,
          source: e.source,
          searchParts: _getSearchParts(e.content)
      )).toList();
      searchResults.add(
        SearchResult(
            title: "Serlevha Hadis",
            searchContents: searchContents,
            resultCount: serlevhaCount,
            bookScope: BookScopeEnum.serlevha
        )
      );
    }

    final sitteCount = await _searchRepo.getCountHadithByBookId(searchedQuery, criteria, BookEnum.sitte.bookId);

    if(sitteCount!=0){
      final hadithSamples = await _searchRepo.getHadithsByBookId(searchedQuery, criteria,BookEnum.sitte.bookId, pageSize, 0);
      final searchContents = hadithSamples.map((e) => SearchContent(
          content: e.content,
          source: e.source,
          searchParts: _getSearchParts(e.content)
      )).toList();
      searchResults.add(
        SearchResult(
            title: "Kütübi Sitte Hadis",
            resultCount: sitteCount,
            searchContents: searchContents,
            bookScope: BookScopeEnum.sitte
        )
      );
    }
    return searchResults;
  }

  List<SearchPart> _getSearchParts(String text){
    final searchParam = SearchParam(
      searchCriteria: state.searchCriteria,
      searchQuery: _queryFilter.value
    );
    return SearchUtils.getSearchParts(
      content: text,
      searchParam: searchParam,
    );
  }
}

