import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/adaptive/presentation/get_card_adaptive_margin.dart';
import 'package:hadith/core/features/adaptive/presentation/single_adaptive_pane.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/pagination/domain/models/paging_config.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/presentation/paging_list_view.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/components/save_auto_save_point_with_paging.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_hadith_item.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_bloc.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_state.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_args_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import './sections/bottom_menu.dart';
import './sections/hadith_icons_handle.dart';
import './sections/header.dart';
import 'components/hadith_item/hadith_item.dart';
import 'paging_hadith_connect.dart';

class HadithSharedPage extends HadithSharedBasePageStateful {

  const HadithSharedPage({
    super.key,
    required super.savePointDestination,
    required super.paginationRepo,
    required super.title,
    required super.pos,
    super.searchParam,
    super.listIdControlForSelectList,
    super.editSavePointHandler,
    super.useWideScopeNaming,
  });

  @override
  State<HadithSharedPage> createState() => _HadithSharedPageState();
}

class _HadithSharedPageState extends State<HadithSharedPage> {
  final CustomScrollController controller = CustomScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    final pagingBloc = context.read<PaginationBloc>();

    pagingBloc.add(PaginationEventInit(widget.paginationRepo, config: PagingConfig(
        pageSize: K.hadithPageSize,currentPos: widget.pos, preFetchDistance: K.hadithPagingPrefetchSize
    )));
  }

  @override
  Widget build(BuildContext context) {
    return AdCheckWidget(
      child: PagingHadithConnect(
        child: SaveAutoSavePointWithPaging(
          destination: widget.savePointDestination,
          autoType: SaveAutoType.general,
          child: Scaffold(
            body: SafeArea(
              child: CustomNestedViewAppBar(
                scrollController: controller,
                floatHeaderSlivers: false,
                title: Text(widget.title),
                actions: widget.getTopBarActions(context),
                child: SingleAdaptivePane(
                  useAdaptivePadding: true,
                  child: BlocBuilder<HadithSharedBloc, HadithSharedState>(
                    builder: (context, state){
                      return PagingListView(
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                        onScroll: (scroll){
                          controller.setScrollDirectionAndAnimateTopBar(scroll);
                        },
                        itemBuilder: (context,itemParam,pos){
                          final item = itemParam?.castOrNull<HadithListModel>();
                          if(item==null){
                            return const Text("");
                          }

                          return HadithItem(
                            margin: getCardAdaptiveMargin(context),
                            key: ValueKey(item.pagingId),
                            hadithList: item,
                            onFavoriteClick: (){
                              widget.handleFavoriteClick(context,hadithListModel: item,state: state);
                            },
                            searchParam: widget.searchParam,
                            fontSize: state.contentFontSize,
                            onLongClick: (){
                              widget.handleBottomMenu(context,hadithListModel: item);
                            },
                            onListClick: (){
                              widget.selectListMenu(context, hadithListModel: item);
                            },
                            onShareClick: (){
                              widget.handleShareMenus(context,hadithListModel: item);
                            },
                          );
                        },
                        loadingItem: const GetShimmerItems(
                          itemCount: 19,
                          shimmerItem: ShimmerHadithItem()
                        ),
                        emptyResultChild: const SharedEmptyResult(
                          content: "Herhangi bir hadis bulunamadı",
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}




