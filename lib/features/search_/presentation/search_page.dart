import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/search_/presentation/bloc/search_event.dart';
import 'package:hadith/features/search_/presentation/bloc/search_state.dart';
import 'package:hadith/features/search_/presentation/sections/history_result.dart';
import 'package:hadith/features/search_/presentation/sections/search_bar.dart';
import 'package:hadith/features/search_/presentation/sections/search_result.dart';
import 'package:hadith/features/search_/presentation/sections/top_bar.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

import 'bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {

  SearchPage({Key? key}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    context.read<SearchBloc>()
        .add(SearchEventSetInit());

    return BlocListener<SearchBloc,SearchState>(
      listenWhen: (prevState, nextState){
        return prevState.isSearchActive!=nextState.isSearchActive;
      },
      listener: (context, state){
        textEditingController.text = state.searchedKey;
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomNestedViewAppBar(
            title: const Text("Arama"),
            actions: getTopBarActions(context),
            headerSlivers: [
              getSliverSearchBar(context)
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                getHeader(),
                getContent(),
                getSearchButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getHeader(){
    return BlocBuilder<SearchBloc,SearchState>(
        builder: (context, state){
          final child = state.isSearchActive ? getSearchResultInfoHeader(context,state) :
              getHistoryHeader(context,state);

          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: child
          );
        }
    );
  }

  Widget getContent(){
    return Expanded(
      child: BlocBuilder<SearchBloc,SearchState>(
          builder: (context, state){
            final child = state.isSearchActive ? getSearchResultContent(context,state) :
                getHistoryContent(context,state);

            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: child
            );
          }
      ),
    );
  }


  Widget getSearchButton(BuildContext context){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: CustomButtonPositive(
        onTap: () {
          context.read<SearchBloc>()
              .add(SearchEventSearch(searchKey: textEditingController.text));
        },
        label: "Ara",
      ),
    );
  }


}
