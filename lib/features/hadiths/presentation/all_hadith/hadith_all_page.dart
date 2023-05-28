import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/paging/paging_config.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/core/features/pagination/paging_loading_item.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/paging_list_view.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/presentation/components/custom_nested_view.dart';
import 'package:hadith/core/presentation/components/dropdown_bar_menu.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_all_paging_repo.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/domain/constants/shared_hadith_bar_item.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import '../shared_components/hadith_item.dart';
import 'bloc/hadith_all_bloc.dart';
import 'bloc/hadith_all_event.dart';
import 'bloc/hadith_all_state.dart';
import 'components/paging_hadith_connect.dart';


class HadithAllPage extends StatelessWidget {
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


  @override
  Widget build(BuildContext context) {

    final bloc = context.read<HadithAllBloc>();
    final pagingBloc = context.read<PaginationBloc>();
    final hadithPagingRepo = context.read<HadithAllPagingRepo>().init(HadithBookEnum.serlevha);

    pagingBloc.add(PaginationEventInit(hadithPagingRepo, config: PagingConfig(
      pageSize: 10,currentPos: 0,preFetchDistance: 3
    )));

    return PagingHadithConnect(
      child: Scaffold(
        body: SafeArea(
          child: CustomNestedView(
            scrollController: controller,
            floatHeaderSlivers: true,
            headerSliverBuilder: (context,innerBoxIsScrolled){
              return [
                CustomSliverAppBar(
                  title: Text("All Hadiths"),
                  actions: [

                    BlocBuilder<PaginationBloc, PaginationState>(
                      buildWhen: (prevState,nextState){
                        return prevState.visibleMinPos != nextState.visibleMinPos;
                      },
                      builder: (context,state){
                        return IconButton(onPressed: (){
                          try{
                            final pos = (state.visibleMinPos + state.visibleMaxPos) ~/ 2;
                            final item = state.items[pos];
                            if(item is HadithListModel){
                              showGetNumberBottomDia(context,(newPos){
                                pagingBloc.add(PaginationEventJumpToPos(pos: newPos));
                              },currentIndex: item.rowNumber,limitIndex: state.totalItems - 1);
                            }
                          }catch (e){}

                        }, icon: const Icon(Icons.map));
                      },
                    ),
                    CustomDropdownBarMenu(
                        items: SharedHadithBarItem.values,
                        selectedFunc: (menuItem){
                          switch(menuItem){
                            case SharedHadithBarItem.fontSize:
                              showSelectFontSizeBottomDia(context);
                              break;
                            case SharedHadithBarItem.savePoint:

                              showEditSavePointsDiaCustom(context,
                                destination: DestinationAll(bookEnum: BookEnum.serlevha),
                                itemIndexPos: 10,
                              );
                              break;
                          }
                        }
                    )
                  ],
                )
              ];
            },
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<HadithAllBloc,HadithAllState>(
                    builder: (context,state){
                      return PagingListView(
                        onScroll: (scroll){
                          scrollWithAnimateTopBar(scroll);
                        },
                        itemBuilder: (context,item,pos){

                          if(item is HadithListModel){
                            return HadithItem(
                              hadithList: item,
                              onFavoriteClick: (){
                                bloc.add(HadithEventFavorite(item: item));
                              },
                              searchParam: null,
                              fontSizeEnum: state.fontSize,
                              onLongClick: (){

                              },
                              onListClick: (){

                              },
                              onShareClick: (){

                              },
                            );
                          }

                          return const Text("");
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
    );
  }
}




