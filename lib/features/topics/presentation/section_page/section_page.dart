import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_topic_item.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_bloc.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_event.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_state.dart';
import 'package:hadith/features/topics/presentation/section_page/section_item.dart';
import 'package:hadith/features/topics/presentation/section_page/section_model.dart';

class SectionPage extends StatefulWidget {
  final BookEnum bookEnum;

  const SectionPage({Key? key, required this.bookEnum}) : super(key: key);

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<SectionBloc>();
    bloc.add(SectionEventLoadData(book: widget.bookEnum));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SectionBloc>();
    return BlocSelector<SectionBloc, SectionState, bool>(
      selector: (state)=>state.searchBarVisible,
      builder: (context,isSearchBarVisible){
        return Scaffold(
          body: SafeArea(
            child: DefaultNestedSearchableAppBar(
              textEditingController: searchTextController,
              searchBarVisible: isSearchBarVisible,
              onSearchVisibilityChanged: (newIsSearchBarVisible){
                bloc.add(SectionEventSetSearchBarVisibility(isSearchBarVisible: newIsSearchBarVisible));
              },
              onTextChanged: (newText){
                bloc.add(SectionEventSearch(query: newText));
              },
              title: Text(
                "Bölüm - ${widget.bookEnum.bookScope.description}",
                overflow: TextOverflow.ellipsis,
              ),
              actions: widget.getActions(context),
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

                    return getItemsContent(items);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getItemsContent(List<SectionModel> items){
    return LazyAlignedGridView(
        maxCrossAxisExtent: 600,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index){
          final item = items[index];
          return SectionItem(
            sectionItem: item.sectionViewModel,
            rowNumber: index == 0 ? null : index,
            onTap: (){
              TopicRoute(
                  bookId: widget.bookEnum.bookId,
                  sectionTitle: item.sectionViewModel.name,
                  sectionId: item.sectionViewModel.id,
                  useBookAllSections: item.isBookSection
              ).push(context);
            },

          );
        }
    );
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
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

