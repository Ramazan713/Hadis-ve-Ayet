import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/share/share_connect.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/presentation/shared/components/list_item.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import 'package:hadith/features/lists/presentation/show_list/sections/components_section.dart';
import 'package:hadith/features/lists/presentation/show_list/sections/handle_bottom_menu_section.dart';
import 'package:hadith/features/lists/presentation/show_list/sections/top_bar_section.dart';

final _searchKey = GlobalKey();

class ShowListPage extends StatelessWidget {
  const ShowListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getListeners(
      child: ShareConnect(
          child: AdaptiveLayout(
            body: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                  key: const Key('List Body Small'),
                  builder: (_){
                    return getContent(context,1);
                  },
                ),
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('List Body Medium'),
                  builder: (_){
                    return getContent(context, 2);
                  }
                )
              },
            ),
          )
        ),
    );
  }

  Widget getContent(BuildContext context,int gridCount){
    final listBloc = context.read<ShowListBloc>();
    return BlocSelector<ShowListBloc, ShowListState,bool>(
      selector: (state)=> state.searchBarVisible,
      builder: (context, searchBarVisible) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            floatingActionButton: getFab(context),
            body: SafeArea(
              child: CustomNestedSearchableAppBar(
                key: _searchKey,
                pinned: true,
                snap: true,
                floating: true,
                searchBarVisible: searchBarVisible,
                onTextChanged: (newText){
                  listBloc.add(ShowListEventSearch(query: newText));
                },
                onSearchVisibilityChanged: (newSearchBarVisible){
                  listBloc.add(ShowListEventSetVisibilitySearchBar(searchBarVisible: newSearchBarVisible));
                },
                actions: getActions(context),
                title: const Text("Listeler"),
                appBarBottom: getTopTabBar(context),
                child: TabBarView(
                  children: [
                    BlocSelector<ShowListBloc,ShowListState,List<ListViewModel>>(
                      selector: (state)=>state.listHadiths,
                      builder: (context,listHadiths){
                        return getListItems(
                            items: listHadiths,
                            gridCount: gridCount,
                            sourceType: SourceTypeEnum.hadith,
                            useSecondary: true
                        );
                      },
                    ),
                    BlocSelector<ShowListBloc,ShowListState,List<ListViewModel>>(
                      selector: (state)=>state.listVerses,
                      builder: (context,listVerses){
                        return getListItems(
                            items: listVerses,
                            gridCount: gridCount,
                            sourceType: SourceTypeEnum.verse,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget getListItems({
    required List<ListViewModel>items,
    required SourceTypeEnum sourceType,
    required int gridCount,
    bool useSecondary = false
  }){

    return AlignedGridView.count(
      crossAxisCount: gridCount,
      crossAxisSpacing: 10,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
        return SharedListItem(
          subTitleTag: sourceType.shortName,
          listViewModel: item,
          useSecondary: useSecondary,
          icon: sourceType.getListIcon(context, item.isRemovable),
          onClick: (){
            switch(sourceType){
              case SourceTypeEnum.hadith:
                HadithListRoute(
                  listId: item.id,
                  sourceId: item.sourceType.sourceId,
                ).push(context);
                break;
              case SourceTypeEnum.verse:
                VerseShowListRoute(
                    listId: item.id,
                    sourceId: item.sourceType.sourceId
                ).push(context);
                break;
            }
          },
          onMenuClick: (){
            showAndManageBottomMenu(context,item,sourceType);
          },
        );
      },
    );
  }
}
