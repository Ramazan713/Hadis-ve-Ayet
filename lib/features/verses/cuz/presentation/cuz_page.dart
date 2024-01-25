import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_staggered_grid_view.dart';
import 'package:hadith/core/features/manage_downloaded_audio/presentation/manage_downloaded_audio_listener.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/domain/enums/topic_save_point_type.dart';
import 'package:hadith/core/features/topic_save_point/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_state.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';
import 'package:hadith/core/features/verse_audio/presentation/compoenents/audio_connect.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/components/download_audio_info_item.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_bloc.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_event.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_state.dart';
import 'package:hadith/features/verses/shared/domain/models/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_topic_model.dart';
import 'package:hadith/features/verses/shared/presentation/components/verse_topic_item.dart';
import 'package:hadith/features/verses/shared/presentation/handlers/verse_topic_bottom_menu_handler.dart';
import 'package:hadith/features/verses/shared/presentation/verse_topic_item/verse_topic_audio_info.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import './sections/components_section.dart';
import './sections/top_bar_section.dart';

class CuzPage extends StatefulWidget {
  const CuzPage({Key? key}) : super(key: key);

  @override
  State<CuzPage> createState() => CuzPageState();
}

class CuzPageState extends State<CuzPage> {

  final AutoScrollController autoScrollController = AutoScrollController();
  final CustomScrollController scrollController = CustomScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final CustomPositionController positionController = CustomPositionController();

  @override
  void initState() {
    super.initState();
    final topicSavePointBloc = context.read<TopicSavePointBloc>();
    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: TopicSavePointTypeCuz()));

    context.read<CuzBloc>().add(CuzEventLoadData());
  }

  @override
  Widget build(BuildContext context) {

    return AudioConnect(
      child: ManageDownloadedAudioListener(
        child: Scaffold(
          floatingActionButton: getFab(),
          body: SafeArea(
            child: DefaultNestedScrollableAppBar(
              title: const Text("Cüz"),
              scrollController: scrollController,
              snap: true,
              floating: true,
              appBarType: AppBarType.defaultBar,
              actions: getActions(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const DownloadAudioInfoItem(),
                      const SizedBox(height: 4,),
                      BlocSelector<TopicSavePointBloc,TopicSavePointState,TopicSavePoint?>(
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
                    ],
                  ),
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
    return LazyStaggeredGridView(
      shrinkWrap: true,
      controller: autoScrollController,
      itemCount: items.length,
      maxCrossAxisExtent: 600,
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
          onClickMoreMenu: (){
            onShowMenu(context,
              item: item,
              cuz: cuz,
              info: info,
              index: index,
              hasSavePoint: hasSavePoint
            );
          },
          onLongPress: (){
            onShowMenu(context,
              item: item,
              cuz: cuz,
              info: info,
              index: index,
              hasSavePoint: hasSavePoint
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

  void onShowMenu(BuildContext context,{
    required Cuz cuz,
    required VerseTopicModel<Cuz> item,
    required bool hasSavePoint,
    required AudioInfoResultModel<int> info,
    required int index
  }){
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

  @override
  void dispose() {
    scrollController.dispose();
    positionController.dispose();
    super.dispose();
  }
}
