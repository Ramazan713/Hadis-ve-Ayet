
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/stack_second_content.dart';
import 'package:hadith/features/search/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/search/presentation/bloc/search_event.dart';
import 'package:hadith/features/search/presentation/bloc/search_state.dart';
import './sections/component_section.dart';
import './sections/history_result_section.dart';
import './sections/search_result_section.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();


}

class SearchPageState extends State<SearchPage> {

  final scrollController = ScrollController();
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<SearchBloc>();
    textEditingController.setTextWithCursor(bloc.state.searchQuery);
  }

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<SearchBloc>();

    return PopScope(
      canPop: true,
      onPopInvoked: (canPop){
        bloc.add(SearchEventSetQuery(query: ""));
      },
      child: GestureDetector(
        onTap: (){
          unFocusBar();
        },
        child: Scaffold(
          body: SafeArea(
            child: AdaptivePadding(
              child: DefaultNestedScrollableAppBar(
                snap: true,
                floating: true,
                toolbarHeight: K.searchBarHeight,
                actions: [
                  Expanded(
                    child: getSearchView(),
                  )
                ],
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getChipActions(),
                      Flexible(
                          child: getContentSwitcher(context, state)
                      )
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
        firstChild: getSearchResultContent(
          state: state,
        ),
        secondChild: getHistoryContent(
          state: state,
        ),
        showFirstChild: state.isSearchActive,
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void unFocusBar(){
    FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
  }
}


