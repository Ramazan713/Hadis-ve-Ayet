


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/features/search/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/search/presentation/bloc/search_event.dart';
import 'package:hadith/features/search/presentation/bloc/search_state.dart';
import 'package:hadith/features/search/presentation/components/history_item.dart';
import 'package:hadith/features/search/presentation/search_page.dart';
import 'package:flutter/material.dart';
import 'package:hadith/features/search/presentation/sections/component_section.dart';
import 'package:hadith/features/search/presentation/sections/functions_section.dart';

extension SearchPageHistoryResultExt on SearchPage{


  Widget getHistoryContent(BuildContext context, SearchState state){

    final searchBloc = context.read<SearchBloc>();
    final histories = state.histories;

    if(histories.isEmpty){
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: SharedEmptyResult(
          content: "geçmiş bulunmamaktadır",
        ),
      );
    }

    return ListView.builder(
        itemCount: histories.length,
        shrinkWrap: true,
        controller: scrollController,
        itemBuilder: (context, index){
          final history = histories[index];
          return HistoryItem(
            history: history,
            onClick: (){
              setTextBar(history.name);
              unFocusBar(context);
              searchBloc.add(SearchEventSetQuery(query: history.name));
            },
            onRemoveClick: (){
              searchBloc.add(SearchEventDeleteHistory(history: history));
            },
          );
        }
    );
  }
}