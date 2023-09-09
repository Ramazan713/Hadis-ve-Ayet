import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_hadith_item.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_bloc.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_event.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_state.dart';
import 'package:hadith/features/topics/presentation/section_page/section_item.dart';
import 'package:hadith/features/topics/presentation/section_page/section_model.dart';


final _searchKey = GlobalKey();

class SectionPage extends StatelessWidget {
  final BookEnum bookEnum;

  SectionPage({Key? key, required this.bookEnum}) : super(key: key);

  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SectionBloc>();
    bloc.add(SectionEventLoadData(book: bookEnum));

    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Section Body Small'),
            builder: (_){
              return getContent(context,1);
            },
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('Section Body Medium'),
              builder: (_){
                return getContent(context, 2);
              }
          )
        },
      ),
    );
  }


  Widget getContent(BuildContext context, int gridCount){
    final bloc = context.read<SectionBloc>();

    return BlocSelector<SectionBloc, SectionState, bool>(
      selector: (state)=>state.searchBarVisible,
      builder: (context,isSearchBarVisible){
        return Scaffold(
          body: SafeArea(
            child: CustomNestedSearchableAppBar(
              key: _searchKey,
              searchBarVisible: isSearchBarVisible,
              onSearchVisibilityChanged: (newIsSearchBarVisible){
                bloc.add(SectionEventSetSearchBarVisibility(isSearchBarVisible: newIsSearchBarVisible));
              },
              onTextChanged: (newText){
                bloc.add(SectionEventSearch(query: newText));
              },
              title: Text("Bölüm - ${bookEnum.bookScope.description}"),
              actions: getActions(context),
              pinned: true,
              snap: false,
              floating: false,
              appBarType: AppBarType.mediumBar,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: BlocBuilder<SectionBloc,SectionState>(
                  builder: (context, state){
                    if(state.isLoading){
                      return const GetShimmerItems(
                        itemCount: 19,
                        shimmerItem: ShimmerTopicItem()
                      );
                    }
                    final items = state.items;

                    if(items.isEmpty){
                      return const SharedEmptyResult();
                    }

                    return getItemsContent(items,gridCount);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getItemsContent(List<SectionModel> items, int gridCount){
    return AlignedGridView.count(
        crossAxisCount: gridCount,
        crossAxisSpacing: 10,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index){
          final item = items[index];
          return SectionItem(
            sectionItem: item.sectionViewModel,
            rowNumber: index == 0 ? null : index,
            onTap: (){
              TopicRoute(
                  bookId: bookEnum.bookId,
                  sectionTitle: item.sectionViewModel.name,
                  sectionId: item.sectionViewModel.id,
                  useBookAllSections: item.isBookSection
              ).push(context);
            },

          );
        }
    );
  }

}





extension SectionPageTopBarExt on SectionPage{

  List<Widget> getActions(BuildContext context){
    return [
      IconButton(
        onPressed: () {
          showSelectSavePoints(context,
            shortTitle: "Konu",
            bookScope: bookEnum.bookScope,
            savePointType: SavePointType.topic,
          );
        },
        icon: const Icon(Icons.save),
        tooltip: "Kayıt Noktası",
      ),
    ];
  }


}

