

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/search_/presentation/bloc/search_event.dart';
import 'package:hadith/features/search_/presentation/search_page.dart';

import '../bloc/search_bloc.dart';

extension SearchPageHistoryResultExt on SearchPage{


  SliverList getSliverSearchBar(BuildContext context){

    return SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 19),
              child: TextField(
                onSubmitted: (text){
                  context.read<SearchBloc>()
                      .add(SearchEventSearch(searchKey: textEditingController.text));
                },
                controller: textEditingController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      textEditingController.clear();
                      context.read<SearchBloc>().add(SearchEventSearch(searchKey: ""));
                    },
                  ),
                  hintText: "Ara",
                ),
              ),
            ),
          ]
      )
    );
  }

}