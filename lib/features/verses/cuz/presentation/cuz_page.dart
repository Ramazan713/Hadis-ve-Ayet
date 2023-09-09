import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/manage_downloaded_audio/manage_downloaded_audio_listener.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/features/topic_save_point/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_edition.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/cuz/domain/enums/cuz_top_bar_menu_item.dart';
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_bloc.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_state.dart';
import 'package:hadith/features/verses/cuz/presentation/sections/components_section.dart';
import 'package:hadith/features/verses/cuz/presentation/sections/top_bar_section.dart';
import 'package:hadith/features/verses/shared/domain/model/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/model/verse_topic_model.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/audio_connect.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/verse_topic_item/verse_topic_audio_info.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/components/download_audio_info_item.dart';
import 'package:hadith/features/verses/shared/presentation/handlers/verse_topic_bottom_menu_handler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../shared/presentation/compoenents/verse_topic_item/verse_topic_item.dart';

class CuzPage extends StatelessWidget {
  CuzPage({Key? key}) : super(key: key);

  final CustomScrollController scrollController = CustomScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final CustomPositionController _positionController = CustomPositionController();

  @override
  Widget build(BuildContext context) {

    final topicSavePointBloc = context.read<TopicSavePointBloc>();
    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: TopicSavePointTypeCuz()));

    return AudioConnect(
      child: ManageDownloadedAudioListener(
        child: Scaffold(
          floatingActionButton: getFab(context),
          body: SafeArea(
            child: CustomNestedViewAppBar(
              title: const Text("Cüz"),
              scrollController: scrollController,
              snap: true,
              floating: true,
              appBarType: AppBarType.defaultBar,
              actions: getActions(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    const DownloadAudioInfoItem(),
                    const SizedBox(height: 4,),
                    Expanded(
                      child: BlocSelector<TopicSavePointBloc,TopicSavePointState,TopicSavePoint?>(
                        selector: (state) => state.topicSavePoint,
                        builder: (context,currentTopicSavePoint){
                          return BlocBuilder<CuzBloc, CuzState>(
                            builder: (context, state){
                              if(state.isLoading){
                                return const GetShimmerItems(
                                  itemCount: 19,
                                  shimmerItem: ShimmerTopicItem()
                                );
                              }
                              final items = state.items;
                              return VerseTopicAudioInfo(
                                selectDownloadState: (state)=>state?.cuzNo,
                                selectListenState: (state)=>state?.cuzNo,
                                builder: (info){
                                  return getPositionedList(
                                    items: items,
                                    currentTopicSavePoint: currentTopicSavePoint,
                                    info: info
                                  );
                                },
                              );
                            }
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getPositionedList({
    required List<VerseTopicModel<Cuz>> items,
    required AudioInfoResultModel<int> info,
    required TopicSavePoint? currentTopicSavePoint
  }){
    return CustomScrollablePositionedList(
      itemCount: items.length,
      delayMilliSeconds: 200,
      onScroll: (scrollDirection){
        scrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
      },
      onVisibleItemChanged: (min,max){
        _positionController.setPositions(min, max,totalItems: items.length);
      },
      itemScrollController: itemScrollController,
      itemBuilder: (context, index){
        final item = items[index];
        final cuz = item.data;
        final hasSavePoint = currentTopicSavePoint?.pos == index;

        return VerseTopicItem(
          label: cuz.name,
          infoResult: info,
          itemId: cuz.no,
          downloadedAudioView: item.audioViewModel,
          hasSavePoint: hasSavePoint,
          iconData: FontAwesomeIcons.bookQuran,
          onLongPress: (){
            verseTopicBottomMenuSharedHandler(context,
              itemId: cuz.no,
              hasSavePoint: hasSavePoint,
              topicModel: item,
              audioResult: info,
              index: index,
              audioOption: QuranAudioOption.cuz,
              onGoToLastSavePoint: (){
                navigateWithSavePoint(context,
                    cuz: cuz,
                    autoType: SaveAutoType.none
                );
              }
            );
          },
          onTap: () {
            navigateWithSavePoint(context,
                cuz: cuz,
                autoType: SaveAutoType.general
            );
          });
      },
    );
  }

  void navigateWithSavePoint(BuildContext context, {
    required SaveAutoType autoType,
    required Cuz cuz
  }){
    context.read<LoadSavePointBloc>().add(LoadSavePointEventLoadLastOrDefault(
      destination: DestinationCuz(
          cuzName: cuz.name,
          cuzId: cuz.no
      ),
      autoType: autoType
    ));
  }


}
