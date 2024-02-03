
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/domain/enums/topic_save_point_type.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/presentation/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon_auto.dart';
import 'package:hadith/core/presentation/dialogs/show_get_number_dia.dart';
import 'package:hadith/core/presentation/selections/show_bottom_menu_items.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/topics/domain/enums/topic_save_point_menu_item.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../topic_page.dart';

import '../bloc/topic_bloc.dart';
import '../bloc/topic_state.dart';

extension TopicPageExt on TopicPageState{

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

  void handleNavigation(TopicViewModel item){
    switch(widget.sourceType){
      case SourceTypeEnum.hadith:
        HadithTopicRoute(
          bookId: widget.bookEnum.bookId,
          topicId: item.id,
        ).push(context);
        break;
      case SourceTypeEnum.verse:
        VerseShowTopicRoute(
          topicId: item.id,
          bookId: widget.bookEnum.bookId,
        ).push(context);
        break;
    }
  }

  void handleBottomMenu({
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
                      bookEnum: widget.bookEnum
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

  TopicSavePointType getTopicType(){
    if(widget.useBookAllSections){
      return TopicSavePointTypeTopicUsesAllBook(bookEnum: widget.bookEnum);
    }
    return TopicSavePointTypeTopic(sectionId: widget.sectionId);
  }
}