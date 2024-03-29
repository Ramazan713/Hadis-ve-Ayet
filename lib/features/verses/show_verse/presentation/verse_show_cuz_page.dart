import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/get_title/domain/enums/title_enum.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_state.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_cuz_paging_repo.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_bloc.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_event.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_state.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/last_page_visible_item.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/shared_providers.dart';
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

    return VerseSharedProviders(
      child: BlocSelector<VerseSharedBloc, VerseSharedState, String>(
        selector: (state) => state.title,
        builder: (context, currentTitle){
          final cuzPagingRepo = context.read<VerseCuzPagingRepo>()
              .init(cuzNo: cuzNo);

          final destination = DestinationCuz(cuzName: currentTitle, cuzId: cuzNo);

          return VerseShowSharedPage(
            savePointDestination: destination,
            paginationRepo: cuzPagingRepo,
            showNavigateToActions: false,
            title: currentTitle,
            pos: pos,
            editSavePointHandler: _getEditSavePointHandler(context),
            trailingWidget: LastPageVisibleItemWithPagination(
              child: getNextPrevButton(context)
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
            final cuzDestination = savePoint.destination.castOrNull<DestinationCuz>();
            if(cuzDestination!=null){
              replaceNavigation(context, cuzNo: cuzDestination.cuzId, pos: savePoint.itemPos);
            }
          }else{
            context.read<PaginationBloc>()
                .add(PaginationEventJumpToPos(pos: savePoint.itemPos));
          }
        },
        onLoadSavePointRequestHandler: (requestHandler){
          showCustomAlertDia(context,
              title: "İçerikler değişecek",
              content: "Yeni bir cüz'e geçmek istediğinize emin misiniz?",
              btnApproved: () {
                requestHandler.call(true);
              });
        },
        onOverrideSavePointRequestHandler: (requestHandler){
          showCustomAlertDia(
              context,
              title: "Kayıt noktası değişecek",
              content: "Farklı bir cüz'e ait kayıt noktasının üzerine yazmak istediğinize emin misiniz?",
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
            onPressed: cuzNo == 1 ? null : (){
              replaceNavigation(context, cuzNo: cuzNo - 1, pos: 0);
            },
            child: const Text("Önceki")
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          child: TextButton(
            onPressed: cuzNo == 30 ? null : (){
              replaceNavigation(context, cuzNo: cuzNo + 1, pos: 0);
            },
            child: const Text("Sonraki")
          ),
        )
      ],
    );
  }

  void replaceNavigation(BuildContext context,{
    required int cuzNo,
    required int pos
  }){
    final location = VerseShowCuzRoute(cuzNo: cuzNo, pos: pos).location;
    context.pushReplacement(location);
  }
}