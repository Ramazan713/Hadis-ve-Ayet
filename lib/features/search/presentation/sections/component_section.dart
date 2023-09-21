
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/presentation/components/search/custom_search_view.dart';
import 'package:hadith/core/presentation/dialogs/show_select_search_criteria.dart';
import 'package:hadith/features/search/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/search/presentation/bloc/search_event.dart';
import 'package:hadith/features/search/presentation/search_page.dart';

extension SearchPageComponentsExt on SearchPage{

  Widget getSearchView(BuildContext context,{
    required TextEditingController textEditingController
  }){
    final bloc = context.read<SearchBloc>();

    return CustomSearchView(
      autofocus: !bloc.state.isSearchActive,
      textEditingController: textEditingController,
      onChanged: (text){
        if(text.isEmpty){
          bloc.add(SearchEventSetQuery(query: ""));
        }else{
          bloc.add(SearchEventSearch(searchKey: text));
        }
      },
      onBackClick: (){
        bloc.add(SearchEventSetQuery(query: ""));
        Navigator.pop(context);
      },
    );
  }


  Widget getChipActions(BuildContext context){
    return Row(
      children: [
        ActionChip(
          label: const Text("Arama Kriteri"),
          avatar: const Icon(Icons.manage_search),
          onPressed: (){
            showSelectSearchCriteria(context);
          },
        ),
        const SizedBox(width: 8,),
        ActionChip(
          label: const Text("Kayıt Noktaları"),
          avatar: const Icon(Icons.save),
          onPressed: (){
            showSelectSavePoints(context,
              shortTitle: "Arama",
              savePointType: SavePointType.search,
            );
          },
        )
      ],
    );
  }



}