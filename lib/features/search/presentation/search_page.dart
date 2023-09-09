
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/stack_second_content.dart';
import 'package:hadith/features/search/presentation/bloc/search_event.dart';
import 'package:hadith/features/search/presentation/sections/component_section.dart';
import 'package:hadith/features/search/presentation/sections/history_result_section.dart';
import 'package:hadith/features/search/presentation/sections/search_result_section.dart';

import 'bloc/search_bloc.dart';
import 'bloc/search_state.dart';


class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);


  final scrollController = ScrollController();
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<SearchBloc>();
    textEditingController.setTextWithCursor(bloc.state.searchQuery);

    return WillPopScope(
      onWillPop: (){
        bloc.add(SearchEventSetQuery(query: ""));
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: (){
          unFocusBar(context);
        },
        child: Scaffold(
          body: SafeArea(
            child: CustomNestedViewAppBar(
              snap: true,
              floating: true,
              toolbarHeight: K.searchBarHeight,
              actions: [
                Expanded(
                  child: getSearchView(context),
                )
              ],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 5),
                child: getMainContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget getMainContent(BuildContext context){
    return Column(
      children: [
        const Divider(),
        Expanded(
          child: BlocBuilder<SearchBloc,SearchState>(
            builder: (context, state){
              if(state.isLoading){
                return const SharedLoadingIndicator();
              }
              return StackSecondContent(
                showStackChild: true,
                getSecondChild: (){
                  if(!state.isSearchActive && state.histories.isEmpty){
                    return const SharedEmptyResult(
                      content: "geçmiş bulunmamaktadır",
                    );
                  }
                  if(state.isSearchActive && state.searchResults.isEmpty){
                    return const SharedEmptyResult();
                  }
                  return null;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      getChipActions(context),
                      getContentSwitcher(context, state)
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget getContentSwitcher(BuildContext context, SearchState state){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomAnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        firstChild: getSearchResultContent(context,state),
        secondChild: getHistoryContent(context,state),
        showFirstChild: state.isSearchActive,
      ),
    );
  }


  void unFocusBar(BuildContext context){
    FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
  }

}


