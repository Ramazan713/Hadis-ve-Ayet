import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/features/backup/presentation/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/presentation/backup/bloc/backup_event.dart';
import 'package:hadith/core/features/backup/presentation/backup/bloc/backup_state.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_full_loading_dia.dart';
import 'package:hadith/features/app/routes/bottom_nav_routers.dart';
import 'package:hadith/core/utils/toast_utils.dart';

class BackupListenConnect extends StatelessWidget {

  final Widget child;

  const BackupListenConnect({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<BackupBloc>();

    return MultiBlocListener(
      listeners: [
        BlocListener<BackupBloc,BackupState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context, state){
            final message = state.message;
            if(message!=null){
              ToastUtils.showLongToast(message);
              bloc.add(BackupEventClearMessage());
            }
          },
        ),
        BlocListener<BackupBloc,BackupState>(
            listenWhen: (prevState, nextState){
              return prevState.loadingEnum != nextState.loadingEnum;
            },
            listener: (context, state){
              final loadingEnum = state.loadingEnum;
              if(loadingEnum == LoadingEnum.loading){
                showFullLoadingDia(context, showLoading: true);
              }else if(loadingEnum == LoadingEnum.completed){
                bloc.add(BackupEventClearCompletedLoading());
                showFullLoadingDia(context, showLoading: false);
              }
            }
        ),
        BlocListener<BackupBloc,BackupState>(
            listenWhen: (prevState, nextState){
              return prevState.refreshApp != nextState.refreshApp;
            },
            listener: (context, state){
              final refreshApp = state.refreshApp;
              if(refreshApp){
                Navigator.of(context,rootNavigator: true).popUntil((route) => route.isFirst);
                HomeRoute().go(context);
                bloc.add(BackupEventClearRefreshApp());
              }
            }
        ),
      ],
      child: child,
    );
  }
}
