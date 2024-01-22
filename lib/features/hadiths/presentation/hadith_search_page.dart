import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_search_paging_repo.dart';

import 'shared/hadith_shared_page.dart';

class HadithSearchPage extends StatelessWidget {

  final String query;
  final BookScopeEnum bookScope;
  final SearchCriteriaEnum searchCriteria;
  final int pos;

  const HadithSearchPage({
    super.key,
    required this.query,
    required this.searchCriteria,
    required this.bookScope,
    required this.pos
  });

  @override
  Widget build(BuildContext context) {
    final destination = DestinationSearch(
        query: query,bookScope: bookScope, criteria: searchCriteria
    );

    final searchPagingRepo = context.read<HadithSearchPagingRepo>()
        .init(destination);

    return HadithSharedPage(
        savePointDestination: destination,
        paginationRepo: searchPagingRepo,
        pos: pos,
        useWideScopeNaming: false,
        searchParam: SearchParam(
            searchCriteria: searchCriteria,
            searchQuery: query
        ),
        title: "$query - ${bookScope.description}",
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
              final location = HadithSearchRoute(
                  query: searchDestination.query,
                  bookScopeId: searchDestination.bookScope.binaryId,
                  criteriaId: searchDestination.criteria.enumValue,
                  pos: savePoint.itemPos
              ).location;
              context.pushReplacement(location);
            }
          }else{
            context.read<PaginationBloc>()
                .add(PaginationEventJumpToPos(pos: savePoint.itemPos));
          }
        },
        onLoadSavePointRequestHandler: (requestHandler){
          showCustomAlertDia(context,
              title: "İçerikler değişecek",
              content: "Farklı bir arama sonuç sayfasına geçmek istediğinize emin misiniz?",
              btnApproved: () {
                requestHandler.call(true);
              });
        },
        onOverrideSavePointRequestHandler: (requestHandler){
          showCustomAlertDia(
              context,
              title: "Kayıt noktası değişecek",
              content: "Farklı bir arama kayıt noktasının üzerine yazmak istediğinize emin misiniz?",
              btnApproved: (){
                requestHandler(true);
              }
          );
        }
    );
  }

}
