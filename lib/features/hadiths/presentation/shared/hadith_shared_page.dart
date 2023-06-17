import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/domain/models/paging/paging_config.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/paging_list_view.dart';
import 'package:hadith/core/features/pagination/paging_loading_item.dart';
import 'package:hadith/core/features/share/share_connect.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_bloc.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_state.dart';
import 'package:hadith/features/hadiths/presentation/shared/sections/bottom_menu.dart';
import 'package:hadith/features/hadiths/presentation/shared/sections/hadith_icons_handle.dart';
import 'package:hadith/features/hadiths/presentation/shared/sections/header.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';

import 'components/hadith_item/hadith_item.dart';
import 'paging_hadith_connect.dart';

 class HadithSharedPage extends StatelessWidget {

  final SavePointDestination savePointDestination;
  final HadithPaginationRepo paginationRepo;
  final String title;
  final SearchParam? searchParam;
  final int pos;
  final int? listIdControlForSelectList;

  HadithSharedPage({
    Key? key,
    required this.savePointDestination,
    required this.paginationRepo,
    required this.title,
    this.searchParam,
    this.listIdControlForSelectList,
    required this.pos
  }) : super(key: key);


  final CustomScrollController controller = CustomScrollController();

  @override
  Widget build(BuildContext context) {

    final pagingBloc = context.read<PaginationBloc>();

    pagingBloc.add(PaginationEventInit(paginationRepo, config: PagingConfig(
        pageSize: 10,currentPos: pos,preFetchDistance: 3
    )));

    return PagingHadithConnect(
      child: ShareConnect(
        child: Scaffold(
          body: SafeArea(
            child: CustomNestedViewAppBar(
              scrollController: controller,
              floatHeaderSlivers: true,
              title: Text(title),
              actions: getTopBarActions(context),
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
                    loadingItem: PagingLoadingItem(
                        loadingWidget: getHadithShimmer(context),
                        childCount: 13
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}




