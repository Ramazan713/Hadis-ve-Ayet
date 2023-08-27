import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/features/auth/bloc/auth_bloc.dart';
import 'package:hadith/core/features/auth/bloc/auth_dialog_event.dart';
import 'package:hadith/core/features/auth/bloc/auth_event.dart';
import 'package:hadith/core/features/auth/bloc/auth_state.dart';
import 'package:hadith/core/features/backup/backup/backup_listen_connect.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_event.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_state.dart';
import 'package:hadith/core/features/backup/backup_meta/show_select_download_backup_dia.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_full_loading_dia.dart';
import 'package:hadith/dialogs/show_alert_bottom_dia_multiple_button.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

class AuthAndBackupListenConnect extends StatelessWidget {

  final Widget child;

  const AuthAndBackupListenConnect({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<AuthBloc>();
    final backupBloc = context.read<BackupBloc>();

    return BackupListenConnect(
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc,AuthState>(
            listenWhen: (prevState, nextState){
              return prevState.message != nextState.message;
            },
            listener: (context, state){
              final message = state.message;
              if(message!=null){
                ToastUtils.showLongToast(message);
                bloc.add(AuthEventClearMessage());
              }
            },
          ),
          BlocListener<AuthBloc,AuthState>(
            listenWhen: (prevState, nextState){
              return prevState.loadingEnum != nextState.loadingEnum;
            },
            listener: (context, state){
              final loadingEnum = state.loadingEnum;
              if(loadingEnum == LoadingEnum.loading){
                showFullLoadingDia(context, showLoading: true);
              }else if(loadingEnum == LoadingEnum.completed){
                bloc.add(AuthEventClearCompletedLoading());
                showFullLoadingDia(context, showLoading: false);
              }
            }
          ),
          BlocListener<AuthBloc,AuthState>(
            listenWhen: (prevState, nextState){
              return prevState.dialogEvent != nextState.dialogEvent;
            },
            listener: (context, state){
              final dialogEvent = state.dialogEvent;
              if(dialogEvent!=null){
                bloc.add(AuthEventClearDialogEvent());
                switch(dialogEvent){
                  case AuthDialogEventShowDiaForDownloadBackup _:
                    showAlertDiaWithMultipleButton(context,
                        title: "Buluttaki yedeğinizi yüklemek ister misiniz?",
                        buttons: [
                          CustomButtonPositive(onTap: (){
                            Navigator.pop(context);
                            backupBloc.add(BackupEventDownloadLastBackup());
                          },label: "En son Yedeği Yükle",),
                          CustomButtonPositive(onTap: (){
                            Navigator.pop(context);
                            showDownloadBackupDia(context);
                          },label: "Yedek dosyalarını göster",),

                          CustomButtonNegative(onTap: (){
                            bloc.add(AuthEventHideDownloadBackupDia());
                            Navigator.pop(context);
                          },label: "Bir daha bu uyarıyı gösterme",),
                          CustomButtonNegative(onTap: () {
                            Navigator.pop(context);
                          },),
                        ]);

                    break;
                  case AuthDialogEventRequestAutoBackup _:
                    backupBloc.add(BackupEventUploadBackup(
                        isAuto: true,
                        actionKey: K.actKeys.uploadBackupForSignOut
                    ));
                    break;
                }
              }
            },
          ),
          BlocListener<BackupBloc,BackupState>(
              listenWhen: (prevState, nextState){
                return prevState.actionResult != nextState.actionResult;
              },
              listener: (context, state){
                final actionResult = state.actionResult;
                if(actionResult != null && actionResult.key == K.actKeys.uploadBackupForSignOut){
                  backupBloc.add(BackupEventClearActionResult());

                  if(actionResult.isSuccess){
                    bloc.add(AuthEventSignOut());
                  }else{
                    showCustomAlertBottomDia(context,title: "Devam etmek istiyor musunuz",
                        content: "Yedekleme işlemi başarısız oldu. Çıkış yaparsanız verileriniz kaybolabilir",
                        btnApproved: ()async{
                          bloc.add(AuthEventSignOut());
                        }
                    );
                  }
                }
              }
          ),
        ],
        child: child,
      ),
    );
  }
}
