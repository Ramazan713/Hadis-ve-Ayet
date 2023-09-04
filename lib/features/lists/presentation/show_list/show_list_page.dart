import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/share/share_connect.dart';
import 'package:hadith/core/presentation/components/animated/custom_visibility_with_scrolling.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/presentation/shared/components/list_item.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import 'package:hadith/features/lists/presentation/show_list/sections/components_section.dart';
import 'package:hadith/features/lists/presentation/show_list/sections/handle_bottom_menu_section.dart';
import 'package:hadith/features/lists/presentation/show_list/sections/top_bar_section.dart';

final _searchKey = GlobalKey();

class ShowListPage extends StatefulWidget {
  const ShowListPage({Key? key}) : super(key: key);

  @override
  State<ShowListPage> createState() => _ShowListPageState();
}

class _ShowListPageState extends State<ShowListPage> {

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return widget.getListeners(
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
                scrollController: CustomScrollController(
                    controller: scrollController
                ),
                onTextChanged: (newText){
                  listBloc.add(ShowListEventSearch(query: newText));
                },
                onSearchVisibilityChanged: (newSearchBarVisible){
                  listBloc.add(ShowListEventSetVisibilitySearchBar(searchBarVisible: newSearchBarVisible));
                },
                actions: widget.getActions(context),
                title: const Text("Listeler"),
                appBarBottom: widget.getTopTabBar(context),
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
            widget.showAndManageBottomMenu(context,item,sourceType);
          },
        );
      },
    );
  }


  Widget getFab(BuildContext context){
    final bloc = context.read<ShowListBloc>();
    return CustomVisibilityWithScrolling(
      controller: scrollController,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          showEditTextDia(context, (text) {
            bloc.add(ShowListEventAddNewList(listName: text));
          },title: "Başlık Girin");
        },
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
