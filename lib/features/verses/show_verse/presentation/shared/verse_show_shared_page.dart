import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/paging/paging_config.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/paging_list_view.dart';
import 'package:hadith/core/features/save_point/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/features/share/share_connect.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/header.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/verse_bottom_menu_section.dart';

import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'bloc/verse_shared_bloc.dart';
import 'bloc/verse_shared_state.dart';
import 'components/paging_verse_connect.dart';
import 'components/verse_item/verse_item.dart';


class VerseShowSharedPage extends StatelessWidget {

  final SavePointDestination savePointDestination;
  final VersePaginationRepo paginationRepo;
  // final HadithSharedDropdownMenu? sharedDropdownMenu;
  final String title;
  final SearchParam? searchParam;
  final int pos;
  final int? listIdControlForSelectList;
  final EditSavePointHandler? editSavePointHandler;

  VerseShowSharedPage({
    Key? key,
    required this.savePointDestination,
    required this.paginationRepo,
    required this.title,
    this.searchParam,
    this.listIdControlForSelectList,
    this.editSavePointHandler,
    required this.pos
  }) : super(key: key);


  final CustomScrollController _customScrollController = CustomScrollController();

  @override
  Widget build(BuildContext context) {

    final pagingBloc = context.read<PaginationBloc>();

    pagingBloc.add(PaginationEventInit(paginationRepo,
        config: PagingConfig(pageSize: 10,preFetchDistance: 3,currentPos: pos)
    ));

    return ShareConnect(
      child: PagingVerseConnect(
        child: Scaffold(
          body: CustomNestedViewAppBar(
            scrollController: _customScrollController,
            title: Text(title),
            actions: getTopBarActions(context),
            child: BlocBuilder<VerseSharedBloc, VerseSharedState>(
              builder: (context, state){
                return PagingListView<VerseListModel>(
                  onScroll: (scrollDirection){
                    _customScrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
                  },
                  itemBuilder: (context, item, index){
                    return VerseItem(
                        fontModel: state.fontModel,
                        arabicVerseUIEnum: state.arabicVerseUIEnum,
                        showListVerseIcons: true,
                        onLongPress: (){
                          handleBottomMenu(
                              context,
                              verseListModel: item,
                              state: state,
                          );
                        },
                        verseListModel: item
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

}
