import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_state.dart';
import 'package:hadith/core/features/topic_save_point/presentation/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon_auto.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/selections/show_bottom_menu_items.dart';
import 'package:hadith/features/topics/domain/enums/topic_save_point_menu_item.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_event.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_state.dart';
import 'package:hadith/features/topics/presentation/topic_page/components/topic_item.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class TopicListPageContent extends StatelessWidget {

  final CustomAutoScrollController autoScrollController;
  final CustomScrollController scrollController;
  final TextEditingController searchTextController;
  final void Function(TopicViewModel) onClickItem;
  final BookEnum bookEnum;
  final int sectionId;
  final bool useBookAllSections;
  final String sectionTitle;
  final bool isSinglePane;

  const TopicListPageContent({
    super.key,
    required this.autoScrollController,
    required this.scrollController,
    required this.searchTextController,
    required this.bookEnum,
    required this.sectionId,
    required this.useBookAllSections,
    required this.sectionTitle,
    required this.onClickItem,
    required this.isSinglePane
  });

  SourceTypeEnum get sourceType => bookEnum.sourceType;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TopicBloc>();

    return Scaffold(
      floatingActionButton: getFloatingActionWidget(),
      body: SafeArea(
        child: BlocSelector<TopicBloc, TopicState, bool>(
          selector: (state)=>state.searchBarVisible,
          builder: (context,isSearchBarVisible){
            return DefaultNestedSearchableAppBar(
              textEditingController: searchTextController,
              scrollController: scrollController,
              contentScrollController: autoScrollController,
              searchBarVisible: isSearchBarVisible,
              onSearchVisibilityChanged: (newIsSearchBarVisible){
                bloc.add(TopicEventSetSearchBarVisibility(isSearchBarVisible: newIsSearchBarVisible));
              },
              onTextChanged: (newText){
                bloc.add(TopicEventSearch(query: newText));
              },
              title: Text(
                "${sectionTitle} - ${bookEnum.bookScope.description}",
                overflow: TextOverflow.ellipsis,
              ),
              actions: getActions(),
              snap: true,
              floating: true,
              floatHeaderSlivers: true,
              appBarType: AppBarType.defaultBar,
              child: getItemsContent(),
            );
          }
        ),
      ),
    );
  }

  Widget getItemsContent(){
    return BlocBuilder<TopicBloc, TopicState>(
      buildWhen: (prevState, nextState){
        return prevState.items != nextState.items ||
            prevState.searchBarVisible != nextState.searchBarVisible ||
            prevState.selectedItem != nextState.selectedItem;
      },
      builder: (context, state){
        final items = state.items;

        return BlocSelector<TopicSavePointBloc,TopicSavePointState, TopicSavePoint?>(
          selector: (state)=>state.topicSavePoint,
          builder: (context, currentTopicSavePoint){
            if(state.isLoading){
              return const GetShimmerItems(
                itemCount: 19,
                shimmerItem: ShimmerTopicItem()
              );
            }
            if(items.isEmpty){
              return const SharedEmptyResult();
            }

            return LazyAlignedGridView(
              shrinkWrap: true,
              controller: autoScrollController.controller,
              padding: K.defaultLazyListPadding,
              maxCrossAxisExtent: 600,
              itemCount: items.length,
              itemBuilder: (context, index){
                final item = items[index];
                final hasSavePoint = currentTopicSavePoint?.pos == index;
                return AutoScrollTag(
                  index: index,
                  key: ValueKey("$index"),
                  controller: autoScrollController.controller,
                  child: TopicItem(
                    isSelected: item.id == state.selectedItem?.id && !isSinglePane,
                    topicViewModel: item,
                    hasSavePoint: !state.searchBarVisible && hasSavePoint,
                    sourceType: sourceType,
                    onTap: (){
                      onClickItem(item);
                    },
                    onMenuClick: state.searchBarVisible ? null : (){
                      handleBottomMenu(
                        context: context,
                          index: index,
                          hasSavePoint: hasSavePoint,
                          topic: item
                      );
                    },
                    rowNumber: index + 1
                  ),
                );
              },
            );
          }
        );
      },
    );
  }


  List<Widget> getActions(){
    return [
      NavigateToIconAuto(
        autoScrollController: autoScrollController,
        onPosChanged: (selectedIndex)async{
          await autoScrollController.scrollToIndex(selectedIndex, preferPosition: AutoScrollPosition.begin);
        },
      ),
    ];
  }

  void handleBottomMenu({
    required BuildContext context,
    required TopicViewModel topic,
    required bool hasSavePoint,
    required int index
  }){
    final topicSavePointBloc = context.read<TopicSavePointBloc>();
    showBottomMenuItems(
        context,
        items: TopicSavePointMenuItem.getMenuItems(hasSavePoint),
        onItemClick: (menuItem){
          switch(menuItem){
            case TopicSavePointMenuItem.goToLastSavePoint:
              context.read<LoadSavePointBloc>().add(LoadSavePointEventLoadLastOrDefault(
                  destination: DestinationTopic(
                      topicId: topic.id,
                      topicName: topic.name,
                      bookEnum: bookEnum
                  ),
                  autoType: SaveAutoType.none
              ));
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

  Widget getFloatingActionWidget(){
    return BlocSelector<TopicBloc,TopicState,bool>(
      selector: (state) => !state.searchBarVisible,
      builder: (context, showFab){
        return TopicSavePointFloatingActionButton(
          controller: scrollController,
          showFab: showFab,
          onSavePointClick: (topicSavePoint){
            autoScrollController.scrollToIndex(
                topicSavePoint.pos,
                duration: const Duration(milliseconds: 300),
                preferPosition: AutoScrollPosition.middle
            );
          },
        );
      }
    );
  }
}
