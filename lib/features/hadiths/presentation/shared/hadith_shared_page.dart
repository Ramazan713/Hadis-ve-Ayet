import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/domain/models/paging/paging_config.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/paging_list_view.dart';
import 'package:hadith/core/features/pagination/paging_loading_item.dart';
import 'package:hadith/core/features/select_list/show_select_list_bottom_dia.dart';
import 'package:hadith/core/features/share/share_connect.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/custom_scroll_controller.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_bloc.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_state.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_scope_widget.dart';
import 'package:hadith/features/hadiths/presentation/shared/handle_menus.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';

import 'bloc/hadith_shared_event.dart';
import 'components/hadith_item.dart';
import 'hadith_shared_dropdown_menu.dart';
import 'hadith_shared_navigator_icon.dart';
import 'paging_hadith_connect.dart';

 class HadithSharedPage extends HadithSharedScopeWidget {

  final SavePointDestination savePointDestination;
  final HadithPaginationRepo paginationRepo;
  final HadithSharedDropdownMenu? sharedDropdownMenu;
  final String title;
  final SearchParam? searchParam;
  final int? listIdControlForSelectList;

  HadithSharedPage({
    Key? key,
    required this.savePointDestination,
    required this.paginationRepo,
    this.sharedDropdownMenu,
    required this.title,
    this.searchParam,
    this.listIdControlForSelectList
  }) : super(key: key);


  final CustomScrollController controller = CustomScrollController();

  @override
  Widget build(BuildContext context) {

    final pagingBloc = context.read<PaginationBloc>();
    final hadithSharedBloc = context.read<HadithSharedBloc>();

    pagingBloc.add(PaginationEventInit(paginationRepo, config: PagingConfig(
        pageSize: 10,currentPos: 0,preFetchDistance: 3
    )));

    return PagingHadithConnect(
      child: ShareConnect(
        child: Scaffold(
          body: SafeArea(
            child: CustomNestedViewAppBar(
              scrollController: controller,
              floatHeaderSlivers: true,
              title: Text(title),
              actions: [
                const HadithSharedNavigatorIcon(),
                sharedDropdownMenu ??
                    HadithSharedDropdownMenu(destination: savePointDestination)
              ],
              child: BlocBuilder<HadithSharedBloc, HadithSharedState>(
                builder: (context, state){
                  return PagingListView(
                    onScroll: (scroll){
                      controller.scrollWithAnimateTopBar(scroll);
                    },
                    itemBuilder: (context,itemParam,pos){
                      final item = itemParam?.castOrNull<HadithListModel>();
                      if(item==null){
                        return const Text("");
                      }

                      return HadithItem(
                        hadithList: item,
                        onFavoriteClick: (){

                          final listFavAffected = state.favListId == listIdControlForSelectList;
                          if(listFavAffected && item.isInFavorite){
                            showCustomAlertBottomDia(
                                context,
                                title: "Favori listesinden kaldırmak istediğinize emin misiniz?",
                                content: "Bulunduğunuz listeyi etkileyecektir",
                                btnApproved: (){
                                  hadithSharedBloc.add(HadithSharedEventFavorite(item: item, listFavAffected: listFavAffected));
                                }
                            );
                          }else{
                            hadithSharedBloc.add(HadithSharedEventFavorite(item: item, listFavAffected: listFavAffected));
                          }
                        },
                        searchParam: searchParam,
                        fontSizeEnum: state.fontSize,
                        onLongClick: (){
                          handleLongClickHadith(
                              context,
                              rowNumber: item.rowNumber,
                              savePointDestination: savePointDestination
                          );
                        },
                        onListClick: (){
                          showSelectListBottomDia(
                              context,
                              listIdControl: listIdControlForSelectList,
                              itemId: item.hadith.id??0,
                              sourceType: SourceTypeEnum.hadith,
                              onDataChanged: (isListAffected){
                                final op = isListAffected ? PagingInvalidateOp.unknown: PagingInvalidateOp.update;
                                pagingBloc.add(PaginationEventInValidate(item: item, op: op, pos: item.rowNumber - 1));
                              },
                          );
                        },
                        onShareClick: (){
                          handleShareMenus(context,item.hadith);
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




