import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/domain/models/paging/i_paging_item.dart';
import 'package:hadith/core/domain/models/paging/paging_config.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/core/features/pagination/paging_loading_item.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/paging_list_view.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_hadith_image.dart';
import 'package:hadith/core/features/share/share_connect.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/custom_nested_view.dart';
import 'package:hadith/core/presentation/components/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/dropdown_bar_menu.dart';
import 'package:hadith/core/presentation/dialogs/showShareAlertDialog.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_all_paging_repo.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_bottom_menu_item.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_share_menu_item.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_top_bar_menu_item.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_dropdown_menu.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_navigator_icon.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import '../shared/components/hadith_item.dart';
import '../shared/hadith_shared_stateless_wdiget.dart';
import 'bloc/hadith_all_bloc.dart';
import 'bloc/hadith_all_event.dart';
import 'bloc/hadith_all_state.dart';
import 'components/paging_hadith_connect.dart';


class HadithAllPage extends HadithSharedStatelessWidget {
  static String id = "HadithAllPage";
  HadithAllPage({Key? key}) : super(key: key);


  final ScrollController controller = ScrollController();

  void scrollWithAnimateTopBar(ScrollDirection scroll){
    switch(scroll){
      case ScrollDirection.up:
        controller.animateTo(
          controller.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        break;
      case ScrollDirection.down:
        controller.animateTo(
            controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn);
        break;
    }
  }

  final destination = DestinationAll(bookEnum: BookEnum.serlevha);

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<HadithAllBloc>();
    final shareBloc = context.read<ShareBloc>();
    final pagingBloc = context.read<PaginationBloc>();
    final hadithPagingRepo = context.read<HadithAllPagingRepo>().init(HadithBookEnum.serlevha);

    pagingBloc.add(PaginationEventInit(hadithPagingRepo, config: PagingConfig(
      pageSize: 10,currentPos: 0,preFetchDistance: 3
    )));

    return PagingHadithConnect(
      child: ShareConnect(
        child: Scaffold(
          body: SafeArea(
            child: CustomNestedViewAppBar(
              scrollController: controller,
              floatHeaderSlivers: true,
              title: Text("All Hadiths"),
              actions: [
                const HadithSharedNavigatorIcon(),
                HadithSharedDropdownMenu(
                    destination: DestinationAll(bookEnum: BookEnum.serlevha),
                )
              ],
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<HadithAllBloc,HadithAllState>(
                      builder: (context,state){
                        return PagingListView(
                          onScroll: (scroll){
                            scrollWithAnimateTopBar(scroll);
                          },
                          itemBuilder: (context,itemParam,pos){
                            final item = itemParam.castOrNull<HadithListModel>();
                            if(item==null){
                              return const Text("");
                            }

                            return HadithItem(
                              hadithList: item,
                              onFavoriteClick: (){
                                bloc.add(HadithEventFavorite(item: item));
                              },
                              searchParam: null,
                              fontSizeEnum: state.fontSize,
                              onLongClick: (){
                                showBottomMenuItems(context,
                                  items: HadithBottomMenuItem.values,
                                  onItemClick: (menuItem){
                                    switch(menuItem){
                                      case HadithBottomMenuItem.savePoint:
                                        Navigator.pop(context);
                                        showEditSavePointsDiaBasic(context,
                                          destination: destination,
                                          itemIndexPos: item.rowNumber,
                                        );
                                        break;
                                    }
                                  },
                                );
                              },
                              onListClick: (){

                              },
                              onShareClick: (){
                                showShareAlertDialog(context,
                                    menuItems: HadithShareMenuItem.values,
                                    onClick: (menuItem){
                                      switch(menuItem){
                                        case HadithShareMenuItem.shareImage:
                                          showPreviewAndShareHadithImage(context,
                                              hadithContent: item.hadith.content,
                                              hadithSource: item.hadith.source,
                                              hadithId: item.hadith.id??0,
                                          );
                                          break;
                                        case HadithShareMenuItem.shareText:
                                          shareBloc.add(ShareEventShareHadithText(hadith: item.hadith));
                                          break;
                                        case HadithShareMenuItem.copyText:
                                          shareBloc.add(ShareEventCopyHadithText(hadith: item.hadith));
                                          break;
                                      }
                                    }
                                );
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




