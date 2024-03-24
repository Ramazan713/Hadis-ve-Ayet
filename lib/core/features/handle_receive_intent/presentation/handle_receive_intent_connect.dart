import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/features/handle_receive_intent/presentation/bloc/handle_receive_intent_bloc.dart';
import 'package:hadith/core/features/handle_receive_intent/presentation/bloc/handle_receive_intent_event.dart';
import 'package:hadith/core/features/handle_receive_intent/presentation/bloc/handle_receive_intent_state.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_event.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_state.dart';
import 'package:hadith/core/features/share/share_ui_event.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_full_loading_dia.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HandleReceiveIntentConnect extends StatelessWidget {
  final Widget child;

  const HandleReceiveIntentConnect({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HandleReceiveIntentBloc>();

   return MultiBlocListener(
      listeners: [
        BlocListener<HandleReceiveIntentBloc,HandleReceiveIntentState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context,state){
            final message = state.message;
            if(message != null){
              ToastUtils.showLongToast(message);
              bloc.add(HandleReceiveIntentEventClearMessage());
            }
          }
        ),
        BlocListener<HandleReceiveIntentBloc,HandleReceiveIntentState>(
          listenWhen: (prevState, nextState){
            return prevState.navigateToCustomPrayer != nextState.navigateToCustomPrayer;
          },
          listener: (context,state){
            final navigateToCustomPrayer = state.navigateToCustomPrayer;
            if(navigateToCustomPrayer){
              bloc.add(HandleReceiveIntentEventClearNavigation());
              CustomPrayersRoute().push(context);
            }
          }
        ),
        BlocListener<HandleReceiveIntentBloc,HandleReceiveIntentState>(
          listenWhen: (prevState, nextState){
            return prevState.loadingEnum != nextState.loadingEnum;
          },
          listener: (context,state){
            final loadingEnum = state.loadingEnum;
            if(loadingEnum == LoadingEnum.loading){
              showFullLoadingDia(context, showLoading: true);
            }else if(loadingEnum == LoadingEnum.completed){
              bloc.add(HandleReceiveIntentEventClearCompletedLoading());
              showFullLoadingDia(context, showLoading: false);
            }
          }
        )
      ],
      child: child,
    );
  }
}
