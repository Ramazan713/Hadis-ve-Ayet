
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/topics/domain/enums/topic_save_point_menu_item.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/topics/presentation/topic_page/topic_page.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../bloc/topic_bloc.dart';
import '../bloc/topic_state.dart';

extension TopicPageExt on TopicPage{
  List<Widget> getActions(BuildContext context,{
    required CustomPositionController positionController,
    required ItemScrollController itemScrollController
  }){
    return [
      NavigateToIcon(
        positionController: positionController,
        onPosChanged: (selectedIndex){
          itemScrollController.jumpTo(index: selectedIndex);
        },
      ),
    ];
  }

  void handleNavigation(BuildContext context, TopicViewModel item){
    switch(sourceType){
      case SourceTypeEnum.hadith:
        HadithTopicRoute(
          bookId: bookEnum.bookId,
          topicId: item.id,
        ).push(context);
        break;
      case SourceTypeEnum.verse:
        VerseShowTopicRoute(
          topicId: item.id,
          bookId: bookEnum.bookId,
        ).push(context);
        break;
    }
  }

  void handleBottomMenu(BuildContext context,{
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

  Widget getFloatingActionWidget({
    required CustomScrollController scrollController,
    required ItemScrollController itemScrollController
  }){
    return BlocSelector<TopicBloc,TopicState,bool>(
        selector: (state) => !state.searchBarVisible,
        builder: (context, showFab){
          return TopicSavePointFloatingActionButton(
            controller: scrollController,
            showFab: showFab,
            onSavePointClick: (topicSavePoint){
              itemScrollController.scrollTo(
                  index: topicSavePoint.pos,
                  duration: const Duration(milliseconds: 300),
                  alignment: 0.5
              );
            },
          );
        }
    );
  }

  TopicSavePointType getTopicType(){
    if(useBookAllSections){
      return TopicSavePointTypeTopicUsesAllBook(bookEnum: bookEnum);
    }
    return TopicSavePointTypeTopic(sectionId: sectionId);
  }
}