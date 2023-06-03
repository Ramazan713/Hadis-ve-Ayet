import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_appbar_searchable.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view.dart';
import 'package:hadith/core/presentation/components/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/features/topics/domain/enums/topic_save_point_menu_item.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_event.dart';
import 'package:hadith/features/topics/presentation/topic_page/components/topic_item.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/widgets/custom_animated_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/topic_state.dart';

class TopicPage extends StatelessWidget {
  final BookEnum bookEnum;
  final int sectionId;
  final bool useBookAllSections;
  final String sectionTitle;

  TopicPage({
    Key? key,
    required this.bookEnum,
    required this.sectionId,
    required this.useBookAllSections,
    required this.sectionTitle
  }) : super(key: key);

  SourceTypeEnum get sourceType => bookEnum.bookScope?.sourceType ?? SourceTypeEnum.hadith;

  final ItemScrollController _itemScrollController = ItemScrollController();
  final CustomScrollController _scrollController = CustomScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TopicBloc>();
    bloc.add(TopicEventLoadData(book: bookEnum, sectionId: sectionId,useBookAllSections: useBookAllSections));

    return BlocSelector<TopicBloc, TopicState, bool>(
      selector: (state)=>state.searchBarVisible,
      builder: (context,isSearchBarVisible){
        return WillPopScope(
          onWillPop: (){
            if(isSearchBarVisible){
              bloc.add(TopicEventSetSearchBarVisibility(isSearchBarVisible: false));
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: Scaffold(
            floatingActionButton: _getFloatingAction(),
            body: SafeArea(
              child: CustomNestedView(
                  scrollController: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      _getAppBar()
                    ];
                  },
                  child: BlocBuilder<TopicBloc, TopicState>(
                    buildWhen: (prevState, nextState){
                      return prevState.items != nextState.items ||
                        prevState.searchBarVisible != nextState.searchBarVisible ||
                        prevState.topicSavePoint != nextState.topicSavePoint;
                    },
                    builder: (context, state){
                      final items = state.items;

                      return CustomScrollablePositionedList(
                        itemCount: items.length,
                        debouncerDelayMilliSeconds: 50,
                        onScroll: (scrollDirection){
                          _scrollController.scrollWithAnimateTopBar(scrollDirection);
                          bloc.add(TopicEventSetScrollDirection(scrollDirection: scrollDirection));
                        },
                        onVisibleItemChanged: (min,max){
                          bloc.add(TopicEventSetVisibleMiddlePos(firstVisiblePos: min, lastVisiblePos: max));
                        },
                        itemScrollController: _itemScrollController,
                        itemPositionsListener: ItemPositionsListener.create(),
                        itemBuilder: (context, index){
                          final item = items[index];
                          final hasSavePoint = state.topicSavePoint?.pos == index;

                          return TopicItem(
                              topicViewModel: item,
                              hasSavePoint: !state.searchBarVisible && hasSavePoint,
                              sourceType: sourceType,
                              onTap: (){

                              },
                              onLongPress: state.searchBarVisible ? null : (){
                                _handleBottomMenu(context, hasSavePoint, index);
                              },
                              rowNumber: index + 1
                          );
                        },
                      );
                    },
                  )
              ),
            ),
          ),
        );
      },
    );
  }


  void _handleBottomMenu(BuildContext context, bool hasSavePoint, int index){
    final bloc = context.read<TopicBloc>();
    showBottomMenuItems(
        context,
        items: TopicSavePointMenuItem.getMenuItems(hasSavePoint),
        onItemClick: (menuItem){
          switch(menuItem){
            case TopicSavePointMenuItem.goToLastSavePoint:
              break;
            case TopicSavePointMenuItem.signSavePoint:
              bloc.add(TopicEventInsertSavePoint(pos: index));
              break;
            case TopicSavePointMenuItem.unSignSavePoint:
              bloc.add(TopicEventDeleteSavePoint());
              break;
          }
          context.pop();
        }
    );
  }


  Widget _getFloatingAction(){
    return BlocBuilder<TopicBloc, TopicState>(
        buildWhen: (prevState, nextState){
          return prevState.topicSavePoint != nextState.topicSavePoint ||
            prevState.searchBarVisible != nextState.searchBarVisible ||
            prevState.scrollDirection != nextState.scrollDirection;
        },
        builder: (context, state){
          final isFabVisible = state.topicSavePoint != null &&
            state.scrollDirection == ScrollDirection.up && !state.searchBarVisible;
          return CustomAnimatedWidget(
            isVisible: isFabVisible,
            child: FloatingActionButton(
              backgroundColor:  Theme.of(context).errorColor,
              onPressed: (){
                final topicSavePoint = state.topicSavePoint;
                if(topicSavePoint!=null){
                  _itemScrollController.jumpTo(index: topicSavePoint.pos);
                }
              },
              child: const Icon(Icons.beenhere),
            ),
          );
        },
    );
  }


}




extension TopicPageTopBarExt on TopicPage{

  Widget _getAppBar(){
    return BlocSelector<TopicBloc, TopicState, bool>(
      selector: (state)=>state.searchBarVisible,
      builder: (context, searchBarVisible){
        return CustomAppBarSearchable(
          searchBarVisible: searchBarVisible,
          onChanged: (text){
            context.read<TopicBloc>().add(TopicEventSearch(query: text));
          },
          onClosed: (){
            context.read<TopicBloc>()
                .add(TopicEventSetSearchBarVisibility(isSearchBarVisible: false));
          },
          sliverAppBar: _sliverAppBar(context),
        );
      },
    );
  }

  CustomSliverAppBar _sliverAppBar(BuildContext context){
    return CustomSliverAppBar(
      title: Text("$sectionTitle - ${bookEnum.bookScope?.description}"),
      snap: true,
      floating: true,
      actions: [

        _getNavigatorMenuItem(),

        IconButton(
          onPressed: () {
            context.read<TopicBloc>()
                .add(TopicEventSetSearchBarVisibility(isSearchBarVisible: true));
          },
          icon: const Icon(Icons.search),
          tooltip: "Ara",
        ),
      ],
    );
  }


  Widget _getNavigatorMenuItem(){
    return BlocBuilder<TopicBloc,TopicState>(
        buildWhen: (prevState,nextState){
          return prevState.middleVisiblePos != nextState.middleVisiblePos ||
              prevState.items.length != nextState.items.length;
        },
        builder: (context, state){
          return  IconButton(
            onPressed: () {
              showGetNumberBottomDia(
                context,
                    (selectedIndex) {
                  _itemScrollController.jumpTo(index: selectedIndex);
                },
                currentIndex: state.middleVisiblePos,
                limitIndex: state.items.length - 1,
              );
            },
            icon: const Icon(Icons.map),
            tooltip: "Navigation",
          );
        }
    );
  }


}
