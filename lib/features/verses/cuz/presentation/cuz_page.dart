import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/features/topic_save_point/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/verse/common_components/audio_state_icon_item.dart';
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_bloc.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_state.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../domain/enums/cuz_save_point_menu_item.dart';
import '../../shared/presentation/compoenents/verse_topic_item.dart';

class CuzPage extends StatelessWidget {
  CuzPage({Key? key}) : super(key: key);

  final CustomScrollController _scrollController = CustomScrollController();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final CustomPositionController _positionController = CustomPositionController();

  @override
  Widget build(BuildContext context) {

    final topicSavePointBloc = context.read<TopicSavePointBloc>();
    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: TopicSavePointTypeCuz()));

    return Scaffold(
      floatingActionButton: TopicSavePointFloatingActionButton(
        showFab: true,
        controller: _scrollController,
        onSavePointClick: (savePoint){
          _itemScrollController.scrollTo(
              index: savePoint.pos,
              duration: const Duration(milliseconds: 300),
              alignment: 0.5
          );
        },
      ),
      body: SafeArea(
        child: CustomNestedViewAppBar(
          title: const Text("Cüz"),
          scrollController: _scrollController,
          actions: [
            IconButton(
              onPressed: () {
                showSelectSavePoints(context,
                  shortTitle: "Cüz",
                  savePointType: SavePointType.cuz,
                  bookScope: BookScopeEnum.diyanetMeal,
                );
              },
              icon: const Icon(Icons.save),
              tooltip: "Kayıt Noktası",
            ),
          ],
          child: BlocBuilder<CuzBloc, CuzState>(
            builder: (context, state){
              final items = state.items;

              return BlocSelector<TopicSavePointBloc,TopicSavePointState,TopicSavePoint?>(
                  selector: (state) => state.topicSavePoint,
                  builder: (context,currentTopicSavePoint){
                    return CustomScrollablePositionedList(
                      itemCount: items.length,
                      delayMilliSeconds: 200,
                      onScroll: (scrollDirection){
                        _scrollController.setScrollDirection(scrollDirection);
                      },
                      onVisibleItemChanged: (min,max){
                        _positionController.setPositions(min, max,totalItems: state.items.length);
                      },
                      itemScrollController: _itemScrollController,
                      itemBuilder: (context, index){
                        final item = items[index];
                        final hasSavePoint = currentTopicSavePoint?.pos == index;

                        return AudioStateIconItem(
                          value: item.no,
                          keyFuncDownload: (state)=>state.getVoiceModel()?.cuzNo,
                          keyFuncAudio: (state)=>state.getAudio()?.cuzNo,
                          builder: (bool isDownloadingActive,bool isAudioRunning){
                            return VerseTopicItem(
                                isDownloadingActive: isDownloadingActive,
                                isAudioRunning: isAudioRunning,
                                hasSavePoint: hasSavePoint,
                                label: item.name,
                                iconData: FontAwesomeIcons.bookQuran,
                                onLongPress: (){
                                  _handleBottomMenu(
                                    context,
                                    hasSavePoint: hasSavePoint,
                                    index: index,
                                    item: item
                                  );
                                },
                                onTap: () {
                                  context.read<LoadSavePointBloc>().add(LoadSavePointEventLoadLastOrDefault(
                                      destination: DestinationCuz(
                                          cuzName: item.name,
                                          cuzId: item.no
                                      ),
                                      autoType: SaveAutoType.general
                                  ));

                                });
                          },
                        );
                      },
                    );
                  });
            },
          ),
        ),
      ),
    );
  }


  void _handleBottomMenu(
      BuildContext context,
  {
    required Cuz item,
    required bool hasSavePoint,
    required int index,
  }
  ){
    final topicSavePointBloc = context.read<TopicSavePointBloc>();
    showBottomMenuItems(
        context,
        items: CuzSavePointMenuItem.getMenuItems(hasSavePoint),
        onItemClick: (menuItem){
          switch(menuItem){
            case CuzSavePointMenuItem.goToLastSavePoint:
              context.read<LoadSavePointBloc>().add(LoadSavePointEventLoadLastOrDefault(
                  destination: DestinationCuz(
                      cuzName: item.name,
                      cuzId: item.no
                  ),
                  autoType: SaveAutoType.none
              ));
              break;
            case CuzSavePointMenuItem.signSavePoint:
              topicSavePointBloc.add(TopicSavePointEventInsertSavePoint(pos: index));
              break;
            case CuzSavePointMenuItem.unSignSavePoint:
              topicSavePointBloc.add(TopicSavePointEventDeleteSavePoint());
              break;
          }
          context.pop();
        }
    );
  }

}
