
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/manage_counter_page.dart';
import 'package:hadith/core/utils/toast_utils.dart';

extension ManageCounterPageListenerExt on ManageCounterPage{

  Widget getListeners({
    required Widget child,
    required BuildContext context
  }){
    final bloc = context.read<ManageCounterBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<ManageCounterBloc,ManageCounterState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context, state){
            final message = state.message;
            if(message!=null){
              ToastUtils.showLongToast(message);
              bloc.add(ManageCounterEventClearMessage());
            }
          },
        ),
        BlocListener<ManageCounterBloc,ManageCounterState>(
          listenWhen: (prevState, nextState){
            return prevState.navigateBack != nextState.navigateBack;
          },
          listener: (context, state){
            final navigateBack = state.navigateBack;
            if(navigateBack){
              bloc.add(ManageCounterEventClearNavigateBack());
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<ManageCounterBloc,ManageCounterState>(
          listenWhen: (prevState, nextState){
            return prevState.currentCounter != nextState.currentCounter;
          },
          listener: (context, state){
            final c = state.currentCounter;
            if(c != null){
              arabicContentController.setTextWithCursor(c.arabicContent ?? "");
              meaningTextController.setTextWithCursor(c.meaning ?? "");
              contentTextController.setTextWithCursor(c.content ?? "");
              nameTextController.setTextWithCursor(c.name);
              goalTextController.setTextWithCursor(c.goal?.toString() ?? "");
              descriptionTextController.setTextWithCursor(c.description ?? "");
            }
          },
        )
      ],
      child: child,
    );
  }
}