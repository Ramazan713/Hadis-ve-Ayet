import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/features/search/domain/model/history.dart';
import 'package:hadith/features/search/domain/model/search_result.dart';



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState{

  const SearchState._();

  const factory SearchState({
    required bool isLoading,
    required String searchQuery,
    required SearchCriteriaEnum searchCriteria,
    required List<History> histories,
    required List<SearchResult> searchResults,
    String? message
  }) = _SearchState;

  static SearchState init(){
    return SearchState(
      isLoading: false,
      searchCriteria: KPref.searchCriteriaEnum.defaultPrefEnum,
      searchQuery: "",
      searchResults: [],
      histories: []
    );
  }

  bool get isSearchActive => searchQuery.trim().isNotEmpty;

  SearchParam get searchParam => SearchParam(
    searchCriteria: searchCriteria,
    searchQuery: searchQuery
  );

}
