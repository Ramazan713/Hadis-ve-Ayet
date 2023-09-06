

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/show_custom_prayers_page.dart';

extension ShowCustomPrayersPageTopBarExt on ShowCustomPrayersPage{

  List<Widget> getActions(BuildContext context){
    return [
      _getViewIcon(context)
    ];
  }

  Widget _getViewIcon(BuildContext context){
    final bloc = context.read<ShowCustomPrayersBloc>();
    return BlocSelector<ShowCustomPrayersBloc,ShowCustomPrayersState,bool>(
      selector: (state)=>state.showDetailContents,
      builder: (context, showDetailContents){
        if(showDetailContents){
          return IconButton(
            onPressed: (){
              bloc.add(ShowCustomPrayersEventSetDetailView(showDetail: false));
            },
            icon: const Icon(Icons.table_rows),
            tooltip: "Liste olarak göster",
          );
        }
        return IconButton(
          onPressed: (){
            bloc.add(ShowCustomPrayersEventSetDetailView(showDetail: true));
          },
          icon: const Icon(Icons.view_agenda),
          tooltip: "Detaylı göster",
        );
      },
    );
  }
}