import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/features/topic_save_point/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_appbar_searchable.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view.dart';
import 'package:hadith/core/presentation/components/navigation_icon.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/topics/domain/enums/topic_save_point_menu_item.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_event.dart';
import 'package:hadith/features/topics/presentation/topic_page/components/topic_item.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';
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

  SourceTypeEnum get sourceType => bookEnum.sourceType;

  final ItemScrollController _itemScrollController = ItemScrollController();
  final CustomScrollController _scrollController = CustomScrollController();
  final CustomPositionController _positionController = CustomPositionController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TopicBloc>();
    final topicSavePointBloc = context.read<TopicSavePointBloc>();

    bloc.add(TopicEventLoadData(book: bookEnum, sectionId: sectionId,useBookAllSections: useBookAllSections));

    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: _getTopicType()));

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
            floatingActionButton: _getFloatingActionWidget(),
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
                        prevState.searchBarVisible != nextState.searchBarVisible;
                    },
                    builder: (context, state){
                      final items = state.items;

                      return BlocSelector<TopicSavePointBloc,TopicSavePointState, TopicSavePoint?>(
                          selector: (state)=>state.topicSavePoint,
                          builder: (context, currentTopicSavePoint){

                            if(state.isLoading){
                              return ListView.builder(itemBuilder: (context, index) {
                                return getTopicShimmer(context);
                              },itemCount: 19,);
                            }

                            return CustomScrollablePositionedList(
                              itemCount: items.length,
                              debouncerDelayMilliSeconds: 50,
                              onScroll: (scrollDirection){
                                _scrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
                              },
                              onVisibleItemChanged: (min,max){
                                _positionController.setPositions(min, max,totalItems: state.items.length);
                              },
                              itemScrollController: _itemScrollController,
                              itemBuilder: (context, index){
                                final item = items[index];
                                final hasSavePoint = currentTopicSavePoint?.pos == index;

                                return TopicItem(
                                    topicViewModel: item,
                                    hasSavePoint: !state.searchBarVisible && hasSavePoint,
                                    sourceType: sourceType,
                                    onTap: (){
                                      _handleNavigation(context, item);
                                    },
                                    onLongPress: state.searchBarVisible ? null : (){
                                      _handleBottomMenu(context, hasSavePoint, index);
                                    },
                                    rowNumber: index + 1
                                );
                              },
                            );
                          });
                    },
                  )
              ),
            ),
          ),
        );
      },
    );
  }


  void _handleNavigation(BuildContext context, TopicViewModel item){
    switch(sourceType){
      case SourceTypeEnum.hadith:
        HadithTopicRoute(
          bookId: bookEnum.bookId,
          topicId: item.id,
        ).push(context);
        break;
      case SourceTypeEnum.verse:
        break;
    }
  }

  void _handleBottomMenu(BuildContext context, bool hasSavePoint, int index){
    final topicSavePointBloc = context.read<TopicSavePointBloc>();
    showBottomMenuItems(
        context,
        items: TopicSavePointMenuItem.getMenuItems(hasSavePoint),
        onItemClick: (menuItem){
          switch(menuItem){
            case TopicSavePointMenuItem.goToLastSavePoint:
              break;
            case TopicSavePointMenuItem.signSavePoint:
              topicSavePointBloc.add(TopicSavePointEventInsertSavePoint(pos: index));
              break;
            case TopicSavePointMenuItem.unSignSavePoint:
              topicSavePointBloc.add(TopicSavePointEventDeleteSavePoint());
              break;
          }
          context.pop();
        }
    );
  }

  Widget _getFloatingActionWidget(){
    return BlocSelector<TopicBloc,TopicState,bool>(
        selector: (state) => !state.searchBarVisible,
        builder: (context, showFab){
          return TopicSavePointFloatingActionButton(
            controller: _scrollController,
            showFab: showFab,
            onSavePointClick: (topicSavePoint){
              _itemScrollController.scrollTo(index: topicSavePoint.pos,
                  duration: const Duration(milliseconds: 300));
            },
          );
        }
    );
  }

  TopicSavePointType _getTopicType(){
    if(useBookAllSections){
      return TopicSavePointTypeTopicUsesAllBook(bookEnum: bookEnum);
    }
    return TopicSavePointTypeTopic(sectionId: sectionId);
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
      title: Text("$sectionTitle - ${bookEnum.bookScope.description}"),
      snap: true,
      floating: true,
      actions: [
        NavigationIcon(
            positionController: _positionController,
            onPosChanged: (selectedIndex){
              _itemScrollController.jumpTo(index: selectedIndex);
            },
        ),
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

}
