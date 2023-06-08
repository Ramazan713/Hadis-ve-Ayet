import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../domain/enums/paging/paging_status.dart';
import '../../domain/enums/paging/scroll_direction.dart';
import '../../domain/models/paging/i_paging_item.dart';
import 'paging_loading_item.dart';
import 'bloc/pagination_bloc.dart';
import 'bloc/pagination_event.dart';
import 'bloc/pagination_state.dart';

class PagingListView<T extends IPagingItem> extends StatelessWidget {

  final Function(ScrollDirection direction)? onScroll;
  final Widget Function(BuildContext, T  , int) itemBuilder;
  final PagingLoadingItem? loadingItem;

  PagingListView({super.key, this.onScroll, required this.itemBuilder, this.loadingItem});

  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {

    final paginationBloc = context.read<PaginationBloc>();

    return BlocConsumer<PaginationBloc, PaginationState>(
      listenWhen: (prevState, nextState) {
        // _pagingState = nextState;
        return prevState.jumpToPos != nextState.jumpToPos;
      },
      listener: (context, state) {
        final jumpToPos = state.jumpToPos;

        if (jumpToPos != null && _itemScrollController.isAttached) {
          _itemScrollController.jumpTo(index: jumpToPos,
              alignment: state.jumpToAlignment);
        }
      },
      buildWhen: (prevState, nextState) {
        return prevState.status != nextState.status ||
            prevState.items != nextState.items;
      },
      builder: (context, state) {
        final items = state.items;
        final status = state.status;
        final itemCount = items.length + 2;

        if (status == PagingStatus.loading) {
          return _getLoadingWidget();
        }

        /*
          when _itemScrollController is not attached and bloc event is jumpToPage,
          _itemScrollController.scrollPos not work properly, so initialScrollIndex solve that problem
        */
        var initialScrollIndex =  !_itemScrollController.isAttached &&
            status.isSuccess ? (state.jumpToPos??0):0;

        return CustomScrollablePositionedList(
          shrinkWrap: false,
          itemCount: itemCount,
          debouncerDelayMilliSeconds: 200,
          initialScrollIndex: initialScrollIndex,
          itemPositionsListener: _itemPositionsListener,
          itemScrollController: _itemScrollController,
          onVisibleItemChanged: (firstPos,lastPos){

            // -1 added because LoadingPlaceholderContent causes adding two extra widget
            final min = firstPos - 1;
            final max = lastPos - 1;

            paginationBloc.add(PaginationEventSetVisiblePos(visibleMaxPos: min, visibleMinPos: max));
            _onFetchPagesWithPositions(context,state,min,max);
          },
          onScroll: (scrollDirection){
            onScroll?.call(scrollDirection);
          },
          itemBuilder: (context, index) {

            final loadingContent = _getLoadingPlaceholderContent(
                status,index,itemCount
            );
            if(loadingContent!=null)return loadingContent;

            final currentIndex = index - 1;
            final item = items[currentIndex];

            return itemBuilder(context, item.castOrNull(), currentIndex);
          },
        );
      },
    );
  }
}


// about extentions of loading widgets
extension _PagingListViewLoadingExt on PagingListView{

  Widget? _getLoadingPlaceholderContent(PagingStatus status,int index, int itemCount){
    if (status.isNextLoading && index == itemCount - 1) {
      return defaultLoading;
    }
    else if (status.isPrevLoading && index == 0) {
      return defaultLoading;
    }
    else if(index == 0){
      return const SizedBox();
    }
    else if (index == itemCount - 1){
      return const SizedBox();
    }
    return null;
  }

  Widget get defaultLoading => const Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  Widget _getLoadingWidget() {
    if (loadingItem == null) {
      return defaultLoading;
    }

    return ListView.builder(
        itemBuilder: (context, index) {
          return loadingItem?.loadingWidget;
        },
        itemCount: loadingItem?.childCount);
  }
}


// about extentions of positions functions
extension _PagingListViewPositionExt on PagingListView {

  void _onFetchPagesWithPositions(
      BuildContext context,
      PaginationState pagingState,
      int firstVisibleItemIndex, int lastVisibleItemIndex,
  ) {
    final paginationBloc = context.read<PaginationBloc>();

    if (firstVisibleItemIndex != -1 && lastVisibleItemIndex != -1) {
      //if first item smaller than preFetch and page is greater than 1
      if (firstVisibleItemIndex <= pagingState.preFetchDistance &&
          pagingState.currentPage > 1) {
        final pos = (lastVisibleItemIndex + firstVisibleItemIndex) ~/ 2;
        paginationBloc.add(PaginationEventFetchPreviousPage(firstPos: pos));
      }
      //if lastVisibleItemIndex and prefetch greater than item size
      else if (lastVisibleItemIndex + pagingState.preFetchDistance >=
              pagingState.items.length - 1 &&
          pagingState.currentPage * pagingState.pageSize <
              pagingState.totalItems) {
        paginationBloc.add(PaginationEventFetchNextPage());
      }
    }
  }
}
