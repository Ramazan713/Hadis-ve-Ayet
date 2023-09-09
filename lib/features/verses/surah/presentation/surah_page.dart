import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/manage_downloaded_audio/manage_downloaded_audio_listener.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/model/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/model/verse_topic_model.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/audio_connect.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/verse_topic_item/verse_topic_audio_info.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/verse_topic_item/verse_topic_item.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/components/download_audio_info_item.dart';
import 'package:hadith/features/verses/shared/presentation/handlers/verse_topic_bottom_menu_handler.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';
import 'package:hadith/features/verses/surah/presentation/sections/surah_ext.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/surah_bloc.dart';
import 'bloc/surah_event.dart';
import 'bloc/surah_state.dart';

final _searchKey = GlobalKey();


class SurahPage extends StatelessWidget {
  SurahPage({Key? key,}) : super(key: key);

  final ItemScrollController itemScrollController = ItemScrollController();
  final CustomScrollController scrollController = CustomScrollController();
  final searchTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurahBloc>();
    final topicSavePointBloc = context.read<TopicSavePointBloc>();

    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: TopicSavePointTypeSurah()));

    return AudioConnect(
      child: ManageDownloadedAudioListener(
        child: Scaffold(
          floatingActionButton: getFab(),
          body: SafeArea(
            child: BlocSelector<SurahBloc, SurahState, bool>(
              selector: (state)=>state.searchBarVisible,
              builder: (context,isSearchBarVisible){
                return CustomNestedSearchableAppBar(
                  key: _searchKey,
                  scrollController: scrollController,
                  searchBarVisible: isSearchBarVisible,
                  onSearchVisibilityChanged: (newIsSearchBarVisible){
                    bloc.add(SurahEventSetSearchBarVisibility(isSearchBarVisible: newIsSearchBarVisible));
                  },
                  onTextChanged: (newText){
                    bloc.add(SurahEventSearch(query: newText));
                  },
                  title: const Text("Sure"),
                  actions: getActions(context),
                  snap: true,
                  floating: true,
                  appBarType: AppBarType.defaultBar,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        const DownloadAudioInfoItem(),
                        const SizedBox(height: 4,),
                        Expanded(
                          child: getContent()
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getContent(){

    return BlocSelector<TopicSavePointBloc,TopicSavePointState, TopicSavePoint?>(
      selector: (state)=>state.topicSavePoint,
      builder: (context, currentTopicSavePoint){
        return BlocBuilder<SurahBloc, SurahState>(
          builder: (context, state){
            final items = state.items;
            if(state.isLoading){
              return const GetShimmerItems(
                itemCount: 19,
                shimmerItem: ShimmerTopicItem()
              );
            }
            if(items.isEmpty){
              return const SharedEmptyResult();
            }

            return VerseTopicAudioInfo(
              selectListenState: (state) => state?.surahId,
              selectDownloadState: (state) => state?.surahId,
              builder: (info){
                return getPositionedList(
                  items: items,
                  info: info,
                  currentTopicSavePoint: currentTopicSavePoint,
                  searchBarVisible: state.searchBarVisible
                );
              },
            );
          }
        );
      }
    );
  }

  Widget getPositionedList({
    required List<VerseTopicModel<Surah>> items,
    required AudioInfoResultModel<int> info,
    required TopicSavePoint? currentTopicSavePoint,
    required bool searchBarVisible
  }){
    return CustomScrollablePositionedList(
      itemCount: items.length,
      delayMilliSeconds: 200,
      onScroll: (scrollDirection){
        scrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
      },
      itemScrollController: itemScrollController,
      itemBuilder: (context, index){
        final item = items[index];
        final surah = item.data;
        final hasSavePoint = currentTopicSavePoint?.pos == index;

        return VerseTopicItem(
          label: "${surah.id}. ${surah.name} ",
          itemId: surah.id,
          downloadedAudioView: item.audioViewModel,
          infoResult: info,
          hasSavePoint: !searchBarVisible && hasSavePoint,
          onTap: (){
            VerseShowSurahRoute(surahId: surah.id)
                .push(context);
          },
          onLongPress: searchBarVisible ? null : (){
            verseTopicBottomMenuSharedHandler(context,
              itemId: surah.id,
              hasSavePoint: hasSavePoint,
              topicModel: item,
              audioResult: info,
              index: index,
              audioOption: QuranAudioOption.surah,
              onGoToLastSavePoint: (){
                context.read<LoadSavePointBloc>().add(LoadSavePointEventLoadLastOrDefault(
                    destination: DestinationSurah(
                        surahName: surah.name,
                        surahId: surah.id
                    ),
                    autoType: SaveAutoType.none
                ));
              }
            );
          },
          iconData: FontAwesomeIcons.bookQuran,
        );
      },
    );
  }
}
