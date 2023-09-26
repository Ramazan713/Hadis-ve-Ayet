
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/show_list_page.dart';

import '../bloc/show_list_bloc.dart';
import '../../../domain/list_tab_enum.dart';

extension ShowListTopBarExt on ShowListPage{


  List<Widget> getActions(BuildContext context){
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

  TabBar getTopTabBar(BuildContext context, {TabController? controller}){
    return TabBar(
      controller: controller,
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