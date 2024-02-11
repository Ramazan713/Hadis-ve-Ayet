import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/get_title/domain/enums/title_enum.dart';
import 'package:hadith/core/features/get_title/presentation/bloc/get_title_bloc.dart';
import 'package:hadith/core/features/get_title/presentation/bloc/get_title_event.dart';
import 'package:hadith/core/features/get_title/presentation/bloc/get_title_state.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_surah_paging_repo.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/last_page_visible_item.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/shared_providers.dart';

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
    final surahPagingRepo = context.read<VerseSurahPagingRepo>().init(surahId: surahId);

    context.read<GetTitleBloc>().add(GetTitleEventRequestTitle(
        itemId: surahId, titleEnum: TitleEnum.surah
    ));

    return VerseSharedProviders(
      child: BlocSelector<GetTitleBloc, GetTitleState, String>(
        selector: (state) => state.title??"",
        builder: (context, currentTitle){
          final destination = DestinationSurah(surahId: surahId,surahName: currentTitle);
          return VerseShowSharedPage(
            savePointDestination: destination,
            paginationRepo: surahPagingRepo,
            showNavigateToActions: false,
            title: currentTitle,
            editSavePointHandler: _getEditSavePointHandler(context),
            pos: pos,
            trailingWidget: LastPageVisibleItemWithPagination(
              child: getNextPrevButton(context),
            ),
          );
        }
      ),
    );
  }



  EditSavePointHandler _getEditSavePointHandler(BuildContext context){
    return EditSavePointHandler(
        onLoadSavePointClick: (savePoint, differentLocation){
          Navigator.pop(context);
          if(differentLocation){
            final surahDestination = savePoint.destination.castOrNull<DestinationSurah>();
            if(surahDestination!=null){
              replaceNavigation(context, surahId: surahDestination.surahId, pos: savePoint.itemPos);
            }
          }else{
            context.read<PaginationBloc>()
                .add(PaginationEventJumpToPos(pos: savePoint.itemPos));
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

  Widget getNextPrevButton(BuildContext context){
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: surahId == 1 ? null : (){
                replaceNavigation(context, surahId: surahId - 1, pos: 0);
              },
              child: const Text("Önceki")
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          child: TextButton(
              onPressed: surahId == 114 ? null : (){
                replaceNavigation(context, surahId: surahId + 1, pos: 0);
              },
              child: const Text("Sonraki")
          ),
        )
      ],
    );
  }

  void replaceNavigation(BuildContext context,{
    required int surahId,
    required int pos
  }){
    final location = VerseShowSurahRoute(surahId: surahId, pos: pos).location;
    context.pushReplacement(location);
  }

}
