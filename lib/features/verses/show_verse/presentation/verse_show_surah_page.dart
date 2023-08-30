import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_surah_paging_repo.dart';

import 'shared/bloc/verse_shared_bloc.dart';
import 'shared/bloc/verse_shared_event.dart';
import 'shared/bloc/verse_shared_state.dart';
import 'shared/verse_show_shared_page.dart';

class VerseShowSurahPage extends StatelessWidget {

  final int surahId;
  final int pos;

  const VerseShowSurahPage({
    Key? key,
    required this.surahId,
    required this.pos
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<VerseSharedBloc>().add(VerseSharedEventSetTitle(
        itemId: surahId, titleEnum: TitleEnum.surah
    ));

    return BlocSelector<VerseSharedBloc, VerseSharedState, String>(
        selector: (state) => state.title,
        builder: (context, currentTitle){

          final surahPagingRepo = context.read<VerseSurahPagingRepo>()
              .init(surahId: surahId);

          final destination = DestinationSurah(surahId: surahId,surahName: currentTitle);

          return VerseShowSharedPage(
            savePointDestination: destination,
            paginationRepo: surahPagingRepo,
            title: currentTitle,
            editSavePointHandler: _getEditSavePointHandler(context),
            pos: pos,
          );
        }
    );
  }

  EditSavePointHandler _getEditSavePointHandler(BuildContext context){
    return EditSavePointHandler(
        onLoadSavePointClick: (savePoint, differentLocation){
          Navigator.pop(context);
          if(differentLocation){
            final surahDestination = savePoint.destination.castOrNull<DestinationSurah>();
            if(surahDestination!=null){
              final location = VerseShowSurahRoute(surahId: surahDestination.surahId, pos: savePoint.itemIndexPos)
                  .location;
              context.replace(location);
            }
          }else{
            context.read<PaginationBloc>()
                .add(PaginationEventJumpToPos(pos: savePoint.itemIndexPos));
          }
        },
        onLoadSavePointRequestHandler: (requestHandler){
          showCustomAlertDia(context,
              title: "İçerikler değişecek",
              content: "Yeni bir sure'ye geçmek istediğinize emin misiniz?",
              btnApproved: () {
                requestHandler.call(true);
              });
        },
        onOverrideSavePointRequestHandler: (requestHandler){
          showCustomAlertDia(
              context,
              title: "Kayıt noktası değişecek",
              content: "Farklı bir sure'ye ait kayıt noktasının üzerine yazmak istediğinize emin misiniz?",
              btnApproved: (){
                requestHandler(true);
              }
          );
        }
    );
  }
  
}
