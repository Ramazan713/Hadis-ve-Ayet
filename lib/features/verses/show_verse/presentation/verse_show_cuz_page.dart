import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_cuz_paging_repo.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_bottom_menu_item.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_bloc.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_event.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_state.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_show_shared_page.dart';

class VerseShowCuzPage extends StatelessWidget {

  final int cuzNo;
  final int pos;

  final int? listIdControlForSelectList = null;

  const VerseShowCuzPage({
    Key? key,
    required this.cuzNo,
    required this.pos
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<VerseSharedBloc>().add(VerseSharedEventSetTitle(
        itemId: cuzNo, titleEnum: TitleEnum.cuz
    ));

    return BlocSelector<VerseSharedBloc, VerseSharedState, String>(
        selector: (state) => state.title,
        builder: (context, currentTitle){
          final cuzPagingRepo = context.read<VerseCuzPagingRepo>()
              .init(cuzNo: cuzNo);

          final destination = DestinationCuz(cuzName: currentTitle, cuzId: cuzNo);

          return VerseShowSharedPage(
            savePointDestination: destination,
            paginationRepo: cuzPagingRepo,
            title: currentTitle,
            pos: pos,
            editSavePointHandler: _getEditSavePointHandler(context),
          );
        }
    );
  }


  EditSavePointHandler _getEditSavePointHandler(BuildContext context){
    return EditSavePointHandler(
        onLoadSavePointClick: (savePoint, differentLocation){
          Navigator.pop(context);
          if(differentLocation){
            final cuzDestination = savePoint.destination.castOrNull<DestinationCuz>();
            if(cuzDestination!=null){
              final location = VerseShowCuzRoute(cuzNo: cuzDestination.cuzId, pos: savePoint.itemIndexPos)
                  .location;
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
              "Yeni bir cüz'e geçmek istediğinize emin misiniz",
              btnApproved: () {
                requestHandler.call(true);
              });
        },
        onOverrideSavePointRequestHandler: (requestHandler){
          showCustomAlertBottomDia(
              context,
              title: "Farklı bir cüz kayıt noktasının üzerine yazmak istediğinize emin misiniz",
              btnApproved: (){
                requestHandler(true);
              }
          );
        }
    );
  }
}