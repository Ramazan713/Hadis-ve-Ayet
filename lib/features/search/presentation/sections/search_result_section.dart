
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/search/presentation/bloc/search_state.dart';
import 'package:hadith/features/search/presentation/components/search_result_collection.dart';
import 'package:hadith/features/search/domain/model/search_result.dart';
import '../search_page.dart';
import 'package:flutter/material.dart';

extension SearchPageSearchResultExt on SearchPageState{

  Widget getSearchResultContent( {
    required SearchState state,
  }){
    final searchResults = state.searchResults;

    return ListView.builder(
        itemCount: searchResults.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index){
          final searchResult = searchResults[index];
          return SearchResultCollection(
            key: Key(searchResult.bookScope.description),
            searchResult: searchResult,
            searchParam: state.searchParam,
            onDetailClick: (){
              unFocusBar();
              _navigateTo(
                  searchResult: searchResult,
                  criteria: state.searchCriteria,
                  query: state.searchQuery
              );
            },
          );
        }
    );
  }

  void _navigateTo({
    required SearchResult searchResult,
    required SearchCriteriaEnum criteria,
    required String query
  }){
    switch(searchResult.bookScope.sourceType){
      case SourceTypeEnum.hadith:
        HadithSearchRoute(
            query: query,
            bookScopeId: searchResult.bookScope.binaryId,
            criteriaId: criteria.enumValue
        ).push(context);
        break;
      case SourceTypeEnum.verse:
        VerseShowSearchRoute(
            query: query,
            bookScopeId: searchResult.bookScope.binaryId,
            criteriaId: criteria.enumValue,
        ).push(context);
        break;
    }
  }


}