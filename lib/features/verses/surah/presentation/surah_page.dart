import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
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
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/verses/shared/domain/models/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_topic_model.dart';
import 'package:hadith/features/verses/shared/presentation/components/verse_topic_item.dart';
import 'package:hadith/features/verses/shared/presentation/handlers/verse_topic_bottom_menu_handler.dart';
import 'package:hadith/features/verses/shared/presentation/verse_topic_item/verse_topic_audio_info.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/surah_bloc.dart';
import 'bloc/surah_event.dart';
import 'bloc/surah_state.dart';
import './sections/surah_ext.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({Key? key,}) : super(key: key);

  @override
  State<SurahPage> createState() => SurahPageState();
}

class SurahPageState extends State<SurahPage> {

  final ItemScrollController itemScrollController = ItemScrollController();
  final CustomScrollController scrollController = CustomScrollController();
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final topicSavePointBloc = context.read<TopicSavePointBloc>();
    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: TopicSavePointTypeSurah()));

    context.read<SurahBloc>().add(SurahEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurahBloc>();

    return AudioConnect(
      child: ManageDownloadedAudioListener(
        child: Scaffold(
          floatingActionButton: getFab(),
          body: SafeArea(
            child: BlocSelector<SurahBloc, SurahState, bool>(
              selector: (state)=>state.searchBarVisible,
              builder: (context,isSearchBarVisible){
                return CustomNestedSearchableAppBar(
                  textEditingController: searchTextController,
                  scrollController: scrollController,
                  searchBarVisible: isSearchBarVisible,
                  onSearchVisibilityChanged: (newIsSearchBarVisible){
                    bloc.add(SurahEventSetSearchBarVisibility(isSearchBarVisible: newIsSearchBarVisible));
                  },
                  onTextChanged: (newText){
                    bloc.add(SurahEventSearch(query: newText));
                  },
                  title: const Text("Sure"),
                  actions: getActions(),
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
          onClickMoreMenu: searchBarVisible ? null : (){
            onShowMenu(context,
                item: item,
                info: info,
                hasSavePoint: hasSavePoint,
                index: index,
                surah: surah
            );
          },
          onLongPress: searchBarVisible ? null : (){
            onShowMenu(context,
              item: item,
              info: info,
              hasSavePoint: hasSavePoint,
              index: index,
              surah: surah
            );
          },
          iconData: FontAwesomeIcons.bookQuran,
        );
      },
    );
  }

  void onShowMenu(BuildContext context,{
    required Surah surah,
    required VerseTopicModel<Surah> item,
    required bool hasSavePoint,
    required AudioInfoResultModel<int> info,
    required int index
  }){
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
  }

  @override
  void dispose() {
    searchTextController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
