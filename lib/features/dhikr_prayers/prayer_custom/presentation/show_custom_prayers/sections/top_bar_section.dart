

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/prayer_custom_top_bar_menu.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_state.dart';

import '../show_custom_prayers_page.dart';

extension ShowCustomPrayersPageTopBarExt on ShowCustomPrayersPageState{

  List<Widget> getActions(BuildContext context){
    final bloc = context.read<ShowCustomPrayersBloc>();
    return [
      _getViewIcon(),
      CustomDropdownIconMenu(
        items: PrayerCustomTopBarMenu.values,
        onSelected: (menuItem)async{
          switch(menuItem){
            case PrayerCustomTopBarMenu.import:
              FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ["json"]);
              final path = result?.files.singleOrNull?.path;
              if (path != null) {
                bloc.add(ShowCustomPrayersEventHandleImport(filePath: path));
              }
              break;
          }
        },
      )
    ];
  }

  Widget _getViewIcon(){
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