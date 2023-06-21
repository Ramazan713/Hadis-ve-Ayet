


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/features/search_/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/search_/presentation/bloc/search_event.dart';
import 'package:hadith/features/search_/presentation/bloc/search_state.dart';
import 'package:hadith/features/search_/presentation/components/history_item.dart';
import 'package:hadith/features/search_/presentation/search_page.dart';
import 'package:flutter/material.dart';

extension SearchPageHistoryResultExt on SearchPage{


  Widget getHistoryHeader(BuildContext context, SearchState state) {
    final searchBloc = context.read<SearchBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "geçmiş ",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
              onPressed: (){
                searchBloc.add(SearchEventClearHistories());
              },
              child: Text(
                "temizle",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              )
          )
        ],
      ),
    );
  }


  Widget getHistoryContent(BuildContext context, SearchState state){

    final searchBloc = context.read<SearchBloc>();

    final histories = state.histories;

    if(state.searchStatus == DataStatus.loading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(histories.isEmpty){
      return Center(
        child: Text("geçmiş bulunmamaktadır",style: Theme.of(context).textTheme.titleMedium,),
      );
    }

    return  ListView.builder(
        itemCount: histories.length,
        itemBuilder: (context, index){
          final history = histories[index];
          return HistoryItem(
            history: history,
            onClick: (){
              textEditingController.text = history.name;
              searchBloc.add(SearchEventSearch(searchKey: history.name));
            },
            onRemoveClick: (){
              searchBloc.add(SearchEventDeleteHistory(history: history));
            },
          );
        }
    );
  }
}