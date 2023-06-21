import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/search_/domain/model/history.dart';
import 'package:hadith/features/search_/presentation/model/search_result.dart';

class SearchState extends Equatable{
  final DataStatus searchStatus;
  final List<SearchResult> searchResults;
  final String searchedKey;
  final List<History> histories;
  final bool isSearchActive;
  final SearchCriteriaEnum searchCriteriaEnum;

  const SearchState({
    required this.searchStatus,
    required this.searchResults,
    required this.searchedKey,
    required this.histories,
    required this.isSearchActive,
    required this.searchCriteriaEnum
  });


  SearchState copyWith({
    DataStatus? searchStatus,
    List<SearchResult>? searchResults,
    String? searchedKey,
    List<History>? histories,
    bool? isSearchActive,
    SearchCriteriaEnum? searchCriteriaEnum
  }){
    return SearchState(
        searchStatus: searchStatus ?? this.searchStatus,
        searchResults: searchResults ?? this.searchResults,
        searchedKey: searchedKey ?? this.searchedKey,
        histories: histories ?? this.histories,
        isSearchActive: isSearchActive ?? this.isSearchActive,
        searchCriteriaEnum: searchCriteriaEnum ?? this.searchCriteriaEnum
    );
  }


  static SearchState init(){
    return SearchState(
        isSearchActive: false,
        histories: const [],
        searchedKey: "",
        searchResults: const [],
        searchStatus: DataStatus.initial,
        searchCriteriaEnum: SearchCriteriaEnum.defaultValue
    );
  }


  @override
  List<Object?> get props => [searchStatus, isSearchActive, histories, searchCriteriaEnum,searchedKey, searchResults];
}