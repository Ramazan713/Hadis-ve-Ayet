

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_page.dart';

extension HadithSharedPageSelectSavePointExt on HadithSharedPage{


  void hadithShowSelectSavePoint(
      BuildContext context,
  {
    required int itemIndexPos,
  }
  ){
    final pagingBloc = context.read<PaginationBloc>();

    if(editSavePointHandler!=null){
      showEditSavePointsDiaAdvanced(
          context,
          destination: savePointDestination,
          itemIndexPos: itemIndexPos,
          onLoadSavePointClick: editSavePointHandler!.onLoadSavePointClick,
          onOverrideSavePointRequestHandler: editSavePointHandler!.onOverrideSavePointRequestHandler,
          onLoadSavePointRequestHandler: editSavePointHandler!.onLoadSavePointRequestHandler);
    }else{
      showEditSavePointsDiaBasic(context,
          destination: savePointDestination,
          itemIndexPos: itemIndexPos,
          onLoadSavePointClick: (savePoint){
            pagingBloc.add(PaginationEventJumpToPos(pos: savePoint.itemIndexPos));
          }
      );
    }
  }

}