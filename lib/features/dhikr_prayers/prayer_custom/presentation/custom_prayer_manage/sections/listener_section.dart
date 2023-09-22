
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/core/utils/toast_utils.dart';

import '../bloc/custom_prayer_manage_bloc.dart';
import '../bloc/custom_prayer_manage_event.dart';
import '../bloc/custom_prayer_manage_state.dart';
import '../custom_prayer_manage_page.dart';

extension CustomPrayerManagePageListenerExt on CustomPrayerManagePage{

  Widget getListeners({
    required Widget child,
    required BuildContext context
  }){
    final bloc = context.read<CustomPrayerManageBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<CustomPrayerManageBloc,CustomPrayerManageState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context, state){
            final message = state.message;
            if(message!=null){
              ToastUtils.showLongToast(message);
              bloc.add(CustomPrayerManageEventClearMessage());
            }
          },
        ),
        BlocListener<CustomPrayerManageBloc,CustomPrayerManageState>(
          listenWhen: (prevState, nextState){
            return prevState.navigateBack != nextState.navigateBack;
          },
          listener: (context, state){
            final navigateBack = state.navigateBack;
            if(navigateBack){
              bloc.add(CustomPrayerManageEventClearNavigateBack());
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<CustomPrayerManageBloc,CustomPrayerManageState>(
          listenWhen: (prevState, nextState){
            return prevState.currentPrayer != nextState.currentPrayer;
          },
          listener: (context, state){
            final c = state.currentPrayer;
            if(c != null){
              arabicContentController.setTextWithCursor(c.arabicContent ?? "");
              meaningTextController.setTextWithCursor(c.meaningContent ?? "");
              contentTextController.setTextWithCursor(c.pronunciationContent ?? "");
              nameTextController.setTextWithCursor(c.name);
              sourceTextController.setTextWithCursor(c.source ?? "");
            }
          },
        )
      ],
      child: child,
    );
  }
}