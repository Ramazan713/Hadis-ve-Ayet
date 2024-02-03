import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/topic_save_point/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_state.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_event.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_state.dart';
import 'package:hadith/features/topics/presentation/topic_page/components/topic_item.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import './sections/topic_ext.dart';

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
  State<TopicPage> createState() => TopicPageState();

  SourceTypeEnum get sourceType => bookEnum.sourceType;
}

class TopicPageState extends State<TopicPage> {

  final CustomAutoScrollController autoScrollController = CustomAutoScrollController(suggestedRowHeight: 60);
  final CustomScrollController scrollController = CustomScrollController();
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<TopicBloc>();
    final topicSavePointBloc = context.read<TopicSavePointBloc>();

    bloc.add(TopicEventLoadData(book: widget.bookEnum, sectionId: widget.sectionId,useBookAllSections: widget.useBookAllSections));
    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: getTopicType()));

  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TopicBloc>();

    return Scaffold(
      floatingActionButton: getFloatingActionWidget(),
      body: SafeArea(
        child: getListeners(
          child: AdaptivePadding(
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
                    "${widget.sectionTitle} - ${widget.bookEnum.bookScope.description}",
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
        ),
      ),
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
                    topicViewModel: item,
                    hasSavePoint: !state.searchBarVisible && hasSavePoint,
                    sourceType: widget.sourceType,
                    onTap: (){
                      handleNavigation(item);
                    },
                    onMenuClick: state.searchBarVisible ? null : (){
                      handleBottomMenu(
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

  Widget getListeners({required Widget child}){
    return BlocListener<TopicBloc,TopicState>(
      listenWhen: (prevState, nextState) => prevState.items.length != nextState.items.length,
      listener: (context, state){
        autoScrollController.setTotalItems(totalItems: state.items.length);
      },
      child: child,
    );
  }


  @override
  void dispose() {
    searchTextController.dispose();
    scrollController.dispose();
    autoScrollController.dispose();
    super.dispose();
  }
}