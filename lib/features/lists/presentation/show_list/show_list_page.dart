import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/presentation/components/animated/custom_visibility_with_scrolling.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
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

class ShowListPage extends StatefulWidget {
  const ShowListPage({Key? key}) : super(key: key);

  @override
  State<ShowListPage> createState() => _ShowListPageState();
}

class _ShowListPageState extends State<ShowListPage> with TickerProviderStateMixin {

  final scrollController = ScrollController();
  final searchTextController = TextEditingController();
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    final initIndex = context.read<ShowListBloc>().state.currentTab.index;
    tabController = TabController(length: 2, vsync: this,initialIndex: initIndex);
    tabController.addListener(listenTabChanges);
  }

  @override
  Widget build(BuildContext context) {

    return widget.getListeners(
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
      ),
    );
  }

  Widget getContent(BuildContext context,int gridCount){
    final listBloc = context.read<ShowListBloc>();

    return BlocSelector<ShowListBloc, ShowListState,bool>(
      selector: (state)=> state.searchBarVisible,
      builder: (context, searchBarVisible) {
        return Scaffold(
          floatingActionButton: getFab(context),
          body: SafeArea(
            child: CustomNestedSearchableAppBar(
              textEditingController: searchTextController,
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
              appBarBottom: widget.getTopTabBar(context, controller: tabController),
              child: TabBarView(
                controller: tabController,
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

    if(items.isEmpty){
      return const SharedEmptyResult();
    }

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

  void listenTabChanges(){
    if(!tabController.indexIsChanging){
      context.read<ShowListBloc>()
          .add(ShowListEventChangeTab(index: tabController.index));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchTextController.dispose();
    tabController.removeListener(listenTabChanges);
    tabController.dispose();
    super.dispose();
  }
}
