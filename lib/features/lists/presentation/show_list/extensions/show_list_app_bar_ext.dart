
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/list/list_archive_screen.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import 'package:hadith/core/presentation/components/app_bar/search_sliver_appbar.dart';
import 'package:hadith/features/settings/setting_screen.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:hadith/features/lists/presentation/show_list/show_list_page.dart';

import '../bloc/show_list_bloc.dart';
import '../models/list_tab_enum.dart';

extension ShowListAppBar on ShowListPage{

  Widget getSelectedAppBar(){
    return BlocSelector<ShowListBloc, ShowListState, bool>(
        selector: (state) => state.searchBarVisible,
        builder: (context, isSearchBarVisible) {
          final appBar = isSearchBarVisible
              ? _getSearchAppBar(context)
              : _getPrimaryAppBar(context);

          return SliverAnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: appBar,
          );
        });
  }


  Widget _getPrimaryAppBar(BuildContext context) {
    final listBloc = context.read<ShowListBloc>();
    return CustomSliverAppBar(
      title: const Text("Listeler"),
      pinned: true,
      snap: true,
      floating: true,
      actions: [
        IconButton(
          onPressed: () {
            ArchiveListRoute().push(context);
          },
          icon: const Icon(Icons.archive),
          tooltip: "Arşiv",
        ),
        IconButton(
          onPressed: () {
            listBloc.add(
                ShowListEventSetVisibilitySearchBar(searchBarVisible: true));
          },
          icon: const Icon(Icons.search),
          tooltip: "Ara",
        ),
        IconButton(
          onPressed: () {
            SettingsRoute().push(context);
          },
          icon: const Icon(Icons.settings),
          tooltip: "Ayarlar",
        )
      ],
      bottom: TabBar(
        tabs: [
          Tab(
            text: ListTabEnum.hadith.sourceType.shortName,
          ),
          Tab(
            text: ListTabEnum.verse.sourceType.shortName,
          ),
        ],
        onTap: (index) {
          listBloc.add(ShowListEventChangeTab(index: index));
        },
      ),
    );
  }

  Widget _getSearchAppBar(BuildContext context) {
    final listBloc = context.read<ShowListBloc>();
    return SearchSliverAppBar(
      onChanged: (text) {
        listBloc.add(ShowListEventSearch(query: text));
      },
      onClosed: () {
        listBloc
            .add(ShowListEventSetVisibilitySearchBar(searchBarVisible: false));
      },
    );
  }
}