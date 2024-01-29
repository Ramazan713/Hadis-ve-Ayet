
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import '../show_list_page.dart';

import '../bloc/show_list_bloc.dart';
import '../../../domain/list_tab_enum.dart';

extension ShowListTopBarExt on ShowListPageState{


  List<Widget> getActions(){
    return [
      IconButton(
        onPressed: () {
          ArchiveListRoute().push(context);
        },
        icon: const Icon(Icons.archive),
        tooltip: "Arşiv",
      ),
      IconButton(
        onPressed: () {
          SettingsRoute().push(context);
        },
        icon: const Icon(Icons.settings),
        tooltip: "Ayarlar",
      )
    ];
  }

  TabBar getTopTabBar(){
    return TabBar(
      controller: tabController,
      tabs: [
        Tab(
          text: ListTabEnum.hadith.sourceType.shortName,
        ),
        Tab(
          text: ListTabEnum.verse.sourceType.shortName,
        ),
      ],
    );
  }
}