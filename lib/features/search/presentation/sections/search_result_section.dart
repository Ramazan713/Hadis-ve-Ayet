
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/search/presentation/bloc/search_state.dart';
import 'package:hadith/features/search/presentation/components/search_result_collection.dart';
import 'package:hadith/features/search/presentation/model/search_result.dart';
import 'package:hadith/features/search/presentation/search_page.dart';
import 'package:flutter/material.dart';
import 'package:hadith/features/search/presentation/sections/functions_section.dart';

extension SearchPageSearchResultExt on SearchPage{

  Widget getSearchResultContent(BuildContext context, SearchState state){

    final searchResults = state.searchResults;

    if(searchResults.isEmpty){
      return const SharedEmptyResult();
    }

    return ListView.builder(
        itemCount: searchResults.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index){
          final searchResult = searchResults[index];
          return SearchResultCollection(
            searchResult: searchResult,
            searchParam: state.searchParam,
            onDetailClick: (){
              unFocusBar(context);
              _navigateTo(
                  context,
                  searchResult: searchResult,
                  criteria: state.searchCriteria,
                  query: state.searchQuery
              );
            },
          );
        }
    );
  }

  void _navigateTo(BuildContext context,{
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