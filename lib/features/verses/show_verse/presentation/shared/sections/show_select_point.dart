

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/domain/enums/local_destination_scope.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_show_shared_page.dart';

extension VerseShowSharedPageSelectSavePointExt on VerseShareBasePage{

  void verseShowSelectSavePoint(BuildContext context, {
    required int itemIndexPos,
    required SavePointDestination savePointDestination,
    void Function(SavePoint)? onLoadSavePointClick,
    LocalDestinationScope? initScope
  }){
    final pagingBloc = context.read<PaginationBloc>();

    if(editSavePointHandler!=null){
      showEditSavePointsDiaAdvanced(
          context,
          destination: savePointDestination,
          itemIndexPos: itemIndexPos,
          initScope: initScope,
          useWideScopeNaming: useWideScopeNaming,
          onLoadSavePointClick: editSavePointHandler!.onLoadSavePointClick,
          onOverrideSavePointRequestHandler: editSavePointHandler!.onOverrideSavePointRequestHandler,
          onLoadSavePointRequestHandler: editSavePointHandler!.onLoadSavePointRequestHandler);
    }else{
      showEditSavePointsDiaBasic(context,
          destination: savePointDestination,
          itemIndexPos: itemIndexPos,
          initScope: initScope,
          onLoadSavePointClick: (savePoint){
            if(onLoadSavePointClick != null){
              onLoadSavePointClick(savePoint);
            }else{
              pagingBloc.add(PaginationEventJumpToPos(pos: savePoint.itemPos));
            }
          }
      );
    }
  }
}