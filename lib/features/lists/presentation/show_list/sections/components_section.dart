

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import 'package:hadith/features/lists/presentation/show_list/show_list_page.dart';
import 'package:hadith/core/utils/toast_utils.dart';

extension ShowListComponentsSectionExt on ShowListPage{


  Widget getListeners({required Widget child}){
    return BlocListener<ShowListBloc, ShowListState>(
      listener: (context,state){
        final message = state.message;
        if(message != null){
          ToastUtils.showLongToast(message);
          context.read<ShowListBloc>()
              .add(ShowListEventClearMessage());
        }
      },
      child: child,
    );
  }


}