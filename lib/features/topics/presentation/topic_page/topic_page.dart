import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_event.dart';
import 'package:hadith/features/topics/presentation/topic_page/components/topic_item.dart';
import 'package:hadith/features/topics/presentation/topic_page/sections/topic_ext.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/topic_state.dart';

final _searchKey = GlobalKey();


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

  final ItemScrollController itemScrollController = ItemScrollController();
  final CustomScrollController scrollController = CustomScrollController();
  final CustomPositionController positionController = CustomPositionController();

  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TopicBloc>();
    final topicSavePointBloc = context.read<TopicSavePointBloc>();

    bloc.add(TopicEventLoadData(book: bookEnum, sectionId: sectionId,useBookAllSections: useBookAllSections));
    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: getTopicType()));

    return BlocSelector<TopicBloc, TopicState, bool>(
        selector: (state)=>state.searchBarVisible,
        builder: (context,isSearchBarVisible){
          return Scaffold(
            floatingActionButton: getFloatingActionWidget(),
            body: SafeArea(
              child: CustomNestedSearchableAppBar(
                key: _searchKey,
                scrollController: scrollController,
                searchBarVisible: isSearchBarVisible,
                onSearchVisibilityChanged: (newIsSearchBarVisible){
                  bloc.add(TopicEventSetSearchBarVisibility(isSearchBarVisible: newIsSearchBarVisible));
                },
                onTextChanged: (newText){
                  bloc.add(TopicEventSearch(query: newText));
                },
                title: Text(
                  "$sectionTitle - ${bookEnum.bookScope.description}",
                  overflow: TextOverflow.ellipsis,
                ),
                actions: getActions(context),
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
              return ListView.builder(itemBuilder: (context, index) {
                return getTopicShimmer(context);
              },itemCount: 19,);
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
                    sourceType: sourceType,
                    onTap: (){
                      handleNavigation(context, item);
                    },
                    onLongPress: state.searchBarVisible ? null : (){
                      handleBottomMenu(
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

}