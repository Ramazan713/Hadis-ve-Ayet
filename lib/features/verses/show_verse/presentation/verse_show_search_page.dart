import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_search_paging_repo.dart';

import 'shared/verse_show_shared_page.dart';

class VerseShowSearchPage extends StatelessWidget{

  final String query;
  final BookScopeEnum bookScope;
  final SearchCriteriaEnum searchCriteria;
  final int pos;

  const VerseShowSearchPage({
    super.key,
    required this.query,
    required this.searchCriteria,
    required this.bookScope,
    required this.pos
  });


  @override
  Widget build(BuildContext context) {

    final destination = DestinationSearch(
        query: query,bookScope: bookScope,criteria: searchCriteria
    );

    final searchPagingRepo = context.read<VerseSearchPagingRepo>()
        .init(destination);

    return VerseShowSharedPage(
      savePointDestination: destination,
      paginationRepo: searchPagingRepo,
      title: query,
      pos: pos,
      searchParam: SearchParam(searchCriteria: searchCriteria, searchQuery: query),
      editSavePointHandler: _getEditSavePointHandler(context),
    );
  }


  EditSavePointHandler _getEditSavePointHandler(BuildContext context){
    return EditSavePointHandler(
        onLoadSavePointClick: (savePoint, differentLocation){
          Navigator.pop(context);
          if(differentLocation){
            final searchDestination = savePoint.destination.castOrNull<DestinationSearch>();
            if(searchDestination!=null){
              final location = VerseShowSearchRoute(
                 query: searchDestination.query,
                 bookScopeId: searchDestination.bookScope.binaryId,
                 criteriaId: searchDestination.criteria.enumValue,
                 pos: savePoint.itemIndexPos
              ).location;
              context.replace(location);
            }
          }else{
            context.read<PaginationBloc>()
                .add(PaginationEventJumpToPos(pos: savePoint.itemIndexPos));
          }
        },
        onLoadSavePointRequestHandler: (requestHandler){
          showCustomAlertBottomDia(context,
              content:
              "Farklı bir arama sonuç sayfasına geçmek istediğinize emin misiniz",
              btnApproved: () {
                requestHandler.call(true);
              });
        },
        onOverrideSavePointRequestHandler: (requestHandler){
          showCustomAlertBottomDia(
              context,
              title: "Farklı bir arama kayıt noktasının üzerine yazmak istediğinize emin misiniz",
              btnApproved: (){
                requestHandler(true);
              }
          );
        }
    );
  }

}