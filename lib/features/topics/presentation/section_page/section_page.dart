import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_appbar_searchable.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view.dart';
import 'package:hadith/core/presentation/components/app_bar/search_sliver_appbar.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_bloc.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_event.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_state.dart';
import 'package:hadith/features/topics/presentation/section_page/section_item.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';

class SectionPage extends StatelessWidget {
  final BookEnum bookEnum;

  const SectionPage({Key? key, required this.bookEnum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SectionBloc>();
    bloc.add(SectionEventLoadData(book: bookEnum));

    return BlocSelector<SectionBloc, SectionState, bool>(
      selector: (state)=>state.searchBarVisible,
      builder: (context,isSearchBarVisible){
        return WillPopScope(
          onWillPop: (){
            if(isSearchBarVisible){
              bloc.add(SectionEventSetSearchBarVisibility(isSearchBarVisible: false));
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: Scaffold(
            body: SafeArea(
              child: CustomNestedView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      _getAppBar()
                    ];
                  },
                  child: BlocBuilder<SectionBloc,SectionState>(
                    builder: (context, state){

                      if(state.isLoading){
                        return ListView.builder(itemBuilder: (context, index) {
                          return getTopicShimmer(context);
                        },itemCount: 19,);
                      }

                      final items = state.items;

                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context,index){
                          final item = items[index];
                          return SectionItem(
                              sectionItem: item.sectionViewModel,
                              onTap: (){
                                TopicRoute(
                                  bookId: bookEnum.bookId,
                                  sectionTitle: item.sectionViewModel.name,
                                  sectionId: item.sectionViewModel.id,
                                  useBookAllSections: item.isBookSection
                                ).push(context);
                              },
                              rowNumber: index == 0 ? null : index
                          );
                        }
                      );
                    },
                  )
              ),
            ),
          ),
        );
      },
    );
  }
}





extension SectionPageTopBarExt on SectionPage{

  Widget _getAppBar(){
    return BlocSelector<SectionBloc, SectionState, bool>(
      selector: (state)=>state.searchBarVisible,
      builder: (context, searchBarVisible){
        return CustomAppBarSearchable(
          searchBarVisible: searchBarVisible,
          onChanged: (text){
            context.read<SectionBloc>().add(SectionEventSearch(query: text));
          },
          onClosed: (){
            context.read<SectionBloc>()
                .add(SectionEventSetSearchBarVisibility(isSearchBarVisible: false));
          },
          sliverAppBar: _sliverAppBar(context),
        );
      },
    );
  }

  CustomSliverAppBar _sliverAppBar(BuildContext context){
    return CustomSliverAppBar(
      title: Text("Bölüm - ${bookEnum.bookScope.description}"),
      snap: true,
      floating: true,
      actions: [
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
        IconButton(
          onPressed: () {
            context.read<SectionBloc>()
                .add(SectionEventSetSearchBarVisibility(isSearchBarVisible: true));
          },
          icon: const Icon(Icons.search),
          tooltip: "Ara",
        ),
      ],
    );
  }

}
