import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/extensions/app_extension.dart';
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
import 'package:hadith/features/hadiths/presentation/shared/components/hadith_item/hadith_item.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_args_widget.dart';
import 'package:hadith/features/hadiths/presentation/shared/paging_hadith_connect.dart';
import 'package:hadith/features/hadiths/presentation/shared/sections/bottom_menu.dart';
import 'package:hadith/features/hadiths/presentation/shared/sections/hadith_icons_handle.dart';
import 'package:hadith/features/hadiths/presentation/shared/sections/header.dart';

class HadithSharedDetailPageContent extends HadithSharedArgsWidget {

  final bool isFullPage;
  final void Function() onClose;
  final CustomScrollController controller;
  final void Function(int firstVisibleItemIndex, int lastVisibleItemIndex)? onVisibleItemChanged;

  const HadithSharedDetailPageContent({
    Key? key,
    required super.savePointDestination,
    required super.paginationRepo,
    required super.title,
    required this.isFullPage,
    required this.onClose,
    super.searchParam,
    super.listIdControlForSelectList,
    super.editSavePointHandler,
    super.useWideScopeNaming,
    required this.controller,
    this.onVisibleItemChanged,
    required super.pos
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagingBloc = context.read<PaginationBloc>();

    pagingBloc.add(PaginationEventInit(paginationRepo, config: PagingConfig(
        pageSize: K.hadithPageSize,currentPos: pos, preFetchDistance: K.hadithPagingPrefetchSize
    )));

    return PopScope(
      canPop: !isFullPage,
      onPopInvoked: (canPop){
        if(!canPop) onClose();
      },
      child: PagingHadithConnect(
        child: SaveAutoSavePointWithPaging(
          destination: savePointDestination,
          autoType: SaveAutoType.general,
          child: Scaffold(
            body: SafeArea(
              child: CustomNestedViewAppBar(
                scrollController: controller,
                floatHeaderSlivers: false,
                leading: getNavigateBackIcon(context),
                showNavigateBack: false,
                title: Text(title),
                actions: getTopBarActions(context),
                child: BlocBuilder<HadithSharedBloc, HadithSharedState>(
                  builder: (context, state){
                    return PagingListView(
                      onVisibleItemChanged: onVisibleItemChanged,
                      onScroll: (scroll){
                        controller.setScrollDirectionAndAnimateTopBar(scroll);
                      },
                      itemBuilder: (context,itemParam,pos){
                        final item = itemParam?.castOrNull<HadithListModel>();
                        if(item==null){
                          return const Text("");
                        }
        
                        return HadithItem(
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
    );
  }

  Widget? getNavigateBackIcon(BuildContext context){
    if(!isFullPage) return null;
    return IconButton(
        onPressed: onClose,
        icon: const Icon(Icons.arrow_back)
    );
  }
}

