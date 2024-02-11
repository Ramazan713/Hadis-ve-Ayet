import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/adaptive/presentation/single_adaptive_pane.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/pagination/domain/models/paging_config.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/presentation/paging_list_view.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/components/save_auto_save_point_with_paging.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_bloc.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_state.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_hadith_item.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_args_widget.dart';
import './sections/show_select_point.dart';
import './sections/header.dart';
import './sections/bottom_menu.dart';
import './sections/hadith_icons_handle.dart';
import 'components/hadith_item/hadith_item.dart';
import 'paging_hadith_connect.dart';

class HadithSharedPage extends HadithSharedArgsWidget {

  HadithSharedPage({
    Key? key,
    required super.savePointDestination,
    required super.paginationRepo,
    required super.title,
    required super.pos,
    super.searchParam,
    super.listIdControlForSelectList,
    super.editSavePointHandler,
    super.useWideScopeNaming,
  }) : super(key: key);


  final CustomScrollController controller = CustomScrollController();

  @override
  Widget build(BuildContext context) {

    final pagingBloc = context.read<PaginationBloc>();

    pagingBloc.add(PaginationEventInit(paginationRepo, config: PagingConfig(
        pageSize: K.hadithPageSize,currentPos: pos, preFetchDistance: K.hadithPagingPrefetchSize
    )));

    return AdCheckWidget(
      child: PagingHadithConnect(
        child: SaveAutoSavePointWithPaging(
          destination: savePointDestination,
          autoType: SaveAutoType.general,
          child: Scaffold(
            body: SafeArea(
              child: CustomNestedViewAppBar(
                scrollController: controller,
                floatHeaderSlivers: false,
                title: Text(title),
                actions: getTopBarActions(context),
                child: SingleAdaptivePane(
                  useAdaptivePadding: true,
                  child: BlocBuilder<HadithSharedBloc, HadithSharedState>(
                    builder: (context, state){
                      return PagingListView(
                        onScroll: (scroll){
                          controller.setScrollDirectionAndAnimateTopBar(scroll);
                        },
                        itemBuilder: (context,itemParam,pos){
                          final item = itemParam?.castOrNull<HadithListModel>();
                          if(item==null){
                            return const Text("");
                          }

                          return HadithItem(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            key: ValueKey(item.pagingId),
                            hadithList: item,
                            onFavoriteClick: (){
                              handleFavoriteClick(context,hadithListModel: item,state: state);
                            },
                            searchParam: searchParam,
                            fontSize: state.contentFontSize,
                            onLongClick: (){
                              handleBottomMenu(context,hadithListModel: item);
                            },
                            onListClick: (){
                              selectListMenu(context, hadithListModel: item);
                            },
                            onShareClick: (){
                              handleShareMenus(context,hadithListModel: item);
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
}




