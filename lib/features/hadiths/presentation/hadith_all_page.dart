import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/pagination/domain/model/paging_config.dart';
import 'package:hadith/core/pagination/domain/model/paging_loading_item.dart';
import 'package:hadith/core/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/pagination/presentation/paging_list_view.dart';
import 'package:hadith/features/hadiths/data/hadith_all_paging_repo.dart';
import 'package:hadith/features/hadiths/domain/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/bloc/hadith_bloc.dart';
import 'package:hadith/features/hadiths/presentation/bloc/hadith_event.dart';
import 'package:hadith/features/hadiths/presentation/hadith_item.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';
import 'bloc/hadith_state.dart';
import 'components/paging_hadith_connect.dart';






class HadithAllPage extends StatelessWidget {
  static String id = "HadithAllPage";
  const HadithAllPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final bloc = context.read<HadithBloc>();
    final pagingBloc = context.read<PaginationBloc>();
    final hadithPagingRepo = context.read<HadithAllPagingRepo>();

    pagingBloc.add(PaginationEventInit(hadithPagingRepo, config: PagingConfig(
      pageSize: 10,currentPos: 357,preFetchDistance: 3
    )));

    return PagingHadithConnect(
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Hadiths"),
          actions: [
            IconButton(onPressed: (){
              pagingBloc.add(PaginationEventJumpToPos(pos: 122));
            }, icon: Icon(Icons.map))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<HadithBloc,HadithState>(
                builder: (context,state){
                  return PagingListView(
                    onScroll: (scroll){
                      // print("scroll: $scroll");
                    },
                    itemBuilder: (context,item,pos){

                      if(item is HadithListModel){
                        return HadithItem(
                          hadithList: item,
                          onFavoriteClick: (){
                            bloc.add(HadithEventFavorite(item: item));
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
    );
  }
}




