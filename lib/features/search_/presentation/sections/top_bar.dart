
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/presentation/dialogs/show_select_search_criteria.dart';
import 'package:hadith/features/search_/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/search_/presentation/bloc/search_event.dart';
import 'package:hadith/features/search_/presentation/search_page.dart';

extension SearchPageHistoryResultExt on SearchPage{


  List<Widget> getTopBarActions(BuildContext context){
    return [
      IconButton(
        onPressed: (){
          showSelectSearchCriteria(context);
        },
        icon: const Icon(Icons.manage_search),
        tooltip: "Arama Kriteri",
      ),
      IconButton(
        onPressed: (){
          showSelectSavePoints(context,
              shortTitle: "Arama",
              menuItems: [SavePointType.search],
              filter: SavePointType.search,
          );
        },
        icon: const Icon(Icons.save),
        tooltip: "Kayıt Noktası",
      ),
      IconButton(
        onPressed: (){

        },
        icon: const Icon(Icons.settings),tooltip: "Ayarlar",
      )
    ];
  }

}