


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/features/search/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/search/presentation/bloc/search_event.dart';
import 'package:hadith/features/search/presentation/bloc/search_state.dart';
import 'package:hadith/features/search/presentation/components/history_item.dart';
import '../search_page.dart';
import 'package:flutter/material.dart';

extension SearchPageHistoryResultExt on SearchPageState{


  Widget getHistoryContent({
    required SearchState state,
  }){
    final searchBloc = context.read<SearchBloc>();
    final histories = state.histories;

    return LazyAlignedGridView(
      maxCrossAxisExtent: 500,
      itemCount: histories.length,
      padding: K.defaultLazyListPadding,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      controller: scrollController,
      itemBuilder: (context, index){
        final history = histories[index];
        return HistoryItem(
          history: history,
          onClick: (){
            textEditingController.setTextWithCursor(history.name);
            unFocusBar();
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