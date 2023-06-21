

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/search_/presentation/bloc/search_state.dart';
import 'package:hadith/features/search_/presentation/components/search_item.dart';
import 'package:hadith/features/search_/presentation/model/search_result.dart';
import 'package:hadith/features/search_/presentation/search_page.dart';
import 'package:flutter/material.dart';

extension SearchPageSearchResultExt on SearchPage{


  Widget getSearchResultInfoHeader(BuildContext context, SearchState state){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19,vertical: 5),
            child: RichText(text: TextSpan(
                children: [
                  TextSpan(
                      text: "${state.searchedKey} ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const TextSpan(text: "kelimesinin sonuçları")
                ],
                style: Theme.of(context).textTheme.bodyMedium
            ))
        )
      ],
    );
  }

  Widget getSearchResultContent(BuildContext context, SearchState state){

    final searchResults = state.searchResults;

    if(state.searchStatus == DataStatus.loading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if(searchResults.isEmpty){
      return Center(
        child: Text("Herhangi bir sonuç bulunamadı",style: Theme.of(context).textTheme.titleMedium,),
      );
    }

    return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index){
          final searchResult = searchResults[index];
          return SearchItem(
              searchResult: searchResult,
              position: index + 1,
              onClick: (){

                _navigateTo(
                    context,
                    searchResult: searchResult,
                    criteria: state.searchCriteriaEnum,
                    query: state.searchedKey
                );
              }
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