import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/domain/enums/paging_status.dart';
import 'package:hadith/core/features/pagination/domain/models/i_paging_item.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_state.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/controllers/custom_page_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PagingListViewByPage<T extends IPagingItem> extends StatelessWidget {

  final Widget Function(BuildContext,T, int) itemBuilder;
  final GetShimmerItems? loadingItem;
  final Widget? emptyResultChild;
  final Widget? trailingWidget;

  final CustomPageController pageController;
  final CustomScrollController? customScrollController;
  final CustomPositionController? positionController;
  final ItemPositionsListener? itemPositionsListener;

  const PagingListViewByPage({
    super.key,
    required this.pageController,
    required this.itemBuilder,
    this.itemPositionsListener,
    this.customScrollController,
    this.positionController,
    this.emptyResultChild,
    this.loadingItem,
    this.trailingWidget
  });


  @override
  Widget build(BuildContext context) {
    final pagingBloc = context.read<PaginationBloc>();

    return BlocBuilder<PaginationBloc,PaginationState>(
      buildWhen: (prevState, nextState){
        return prevState.status != nextState.status ||
            prevState.itemsByPage.keys != nextState.itemsByPage.keys ||
            prevState.totalStaticItems != nextState.totalStaticItems;
      },
      builder: (context, pagingState){
        final itemsByPage = pagingState.itemsByPage;

        return PageView.builder(
          controller: pageController.controller,
          onPageChanged: (page){
            pagingBloc.add(PaginationEventChangePage(page: page + 1));
          },
          itemCount: pagingState.totalStaticItems,
          itemBuilder: (context, pageIndex){

            if(pagingState.status == PagingStatus.loading){
              return getLoadingWidget();
            }

            final items = itemsByPage[pageIndex + 1];
            if(items == null){
              return getLoadingWidget();
            }
            if(items.isEmpty){
              return getEmptyWidget();
            }
            return getPositionsList(context, items);
          },
        );
      },
    );
  }

  Widget getPositionsList(BuildContext context, List<IPagingItem> items){
    final itemsCount = items.length;
    final itemsCountWithTrailing = itemsCount + (trailingWidget != null ? 1 : 0);

    return CustomScrollablePositionedList(
        delayMilliSeconds: 500,
        shrinkWrap: true,
        itemCount: itemsCountWithTrailing,
        singlePositionController: pageController.positionController,
        itemScrollController: ItemScrollController(),
        itemPositionsListener: itemPositionsListener,
        onScroll: (scrollDirection){
          customScrollController?.setScrollDirectionAndAnimateTopBar(scrollDirection);
        },
        onVisibleItemChanged: (firstPos,lastPos){
          positionController?.setPositions(firstPos, lastPos);
        },
        itemBuilder: (context, index){

          if(trailingWidget != null && index == itemsCountWithTrailing - 1){
            return trailingWidget!;
          }

          final item = items[index];

          final castedItem = item.castOrNull<T>();
          if(castedItem == null) return const Text("");

          return itemBuilder(context, castedItem, index);
        }
    );
  }


  Widget getLoadingWidget(){
    return loadingItem ?? const SharedLoadingIndicator();
  }

  Widget getEmptyWidget(){
    return emptyResultChild ?? const SharedEmptyResult();
  }

}
