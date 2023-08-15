
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/add_counter_page.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/bloc/add_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/bloc/add_counter_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/bloc/add_counter_state.dart';
import 'package:hadith/utils/toast_utils.dart';

extension AddCounterPageListenerExt on AddCounterPage{

  Widget getListeners({
    required Widget child,
    required BuildContext context
  }){
    final bloc = context.read<AddCounterBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<AddCounterBloc,AddCounterState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context, state){
            final message = state.message;
            if(message!=null){
              ToastUtils.showLongToast(message);
              bloc.add(AddCounterEventClearMessage());
            }
          },
        ),
        BlocListener<AddCounterBloc,AddCounterState>(
          listenWhen: (prevState, nextState){
            return prevState.navigateBack != nextState.navigateBack;
          },
          listener: (context, state){
            final navigateBack = state.navigateBack;
            if(navigateBack){
              bloc.add(AddCounterEventClearNavigateBack());
              Navigator.pop(context);
            }
          },
        )
      ],
      child: child,
    );
  }
}