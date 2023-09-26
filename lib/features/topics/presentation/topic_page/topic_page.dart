import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_event.dart';
import 'package:hadith/features/topics/presentation/topic_page/components/topic_item.dart';
import 'package:hadith/features/topics/presentation/topic_page/sections/topic_ext.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'bloc/topic_state.dart';

class TopicPage extends StatefulWidget {
  final BookEnum bookEnum;
  final int sectionId;
  final bool useBookAllSections;
  final String sectionTitle;

  const TopicPage({
    Key? key,
    required this.bookEnum,
    required this.sectionId,
    required this.useBookAllSections,
    required this.sectionTitle
  }) : super(key: key);

  @override
  State<TopicPage> createState() => _TopicPageState();

  SourceTypeEnum get sourceType => bookEnum.sourceType;
}

class _TopicPageState extends State<TopicPage> {

  final ItemScrollController itemScrollController = ItemScrollController();
  final CustomScrollController scrollController = CustomScrollController();
  final CustomPositionController positionController = CustomPositionController();
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<TopicBloc>();
    final topicSavePointBloc = context.read<TopicSavePointBloc>();

    bloc.add(TopicEventLoadData(book: widget.bookEnum, sectionId: widget.sectionId,useBookAllSections: widget.useBookAllSections));
    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: widget.getTopicType()));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TopicBloc>();

    return BlocSelector<TopicBloc, TopicState, bool>(
        selector: (state)=>state.searchBarVisible,
        builder: (context,isSearchBarVisible){
          return Scaffold(
            floatingActionButton: widget.getFloatingActionWidget(
              scrollController: scrollController,
              itemScrollController: itemScrollController
            ),
            body: SafeArea(
              child: CustomNestedSearchableAppBar(
                textEditingController: searchTextController,
                scrollController: scrollController,
                searchBarVisible: isSearchBarVisible,
                onSearchVisibilityChanged: (newIsSearchBarVisible){
                  bloc.add(TopicEventSetSearchBarVisibility(isSearchBarVisible: newIsSearchBarVisible));
                },
                onTextChanged: (newText){
                  bloc.add(TopicEventSearch(query: newText));
                },
                title: Text(
                  "${widget.sectionTitle} - ${widget.bookEnum.bookScope.description}",
                  overflow: TextOverflow.ellipsis,
                ),
                actions: widget.getActions(context,
                  itemScrollController: itemScrollController,
                  positionController: positionController
                ),
                snap: true,
                floating: true,
                appBarType: AppBarType.defaultBar,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: getItemsContent(),
                ),
              ),
            )
          );
        }
    );
  }

  Widget getItemsContent(){
    return BlocBuilder<TopicBloc, TopicState>(
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
              return const GetShimmerItems(
                itemCount: 19,
                shimmerItem: ShimmerTopicItem()
              );
            }
            if(items.isEmpty){
              return const SharedEmptyResult();
            }

            return CustomScrollablePositionedList(
              itemCount: items.length,
              delayMilliSeconds: 50,
              onScroll: (scrollDirection){
                scrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
              },
              onVisibleItemChanged: (min,max){
                positionController.setPositions(min, max,totalItems: state.items.length);
              },
              itemScrollController: itemScrollController,
              itemBuilder: (context, index){
                final item = items[index];
                final hasSavePoint = currentTopicSavePoint?.pos == index;

                return TopicItem(
                  topicViewModel: item,
                  hasSavePoint: !state.searchBarVisible && hasSavePoint,
                  sourceType: widget.sourceType,
                  onTap: (){
                    widget.handleNavigation(context, item);
                  },
                  onMenuClick: state.searchBarVisible ? null : (){
                    widget.handleBottomMenu(
                      context,
                      index: index,
                      hasSavePoint: hasSavePoint,
                      topic: item
                    );
                  },
                  rowNumber: index + 1
                );
              },
            );
          }
        );
      },
    );
  }


  @override
  void dispose() {
    searchTextController.dispose();
    scrollController.dispose();
    positionController.dispose();
    super.dispose();
  }
}