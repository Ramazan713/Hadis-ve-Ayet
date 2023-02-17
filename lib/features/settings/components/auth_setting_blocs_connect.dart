

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hadith/dialogs/show_alert_bottom_dia_multiple_button.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/backup/show_cloud_download_backup_dia.dart';
import 'package:hadith/features/settings/audio_setting/bloc/audio_setting_bloc.dart';
import 'package:hadith/features/settings/auth_bloc/auth_bloc.dart';
import 'package:hadith/features/settings/auth_bloc/auth_event.dart';
import 'package:hadith/features/settings/auth_bloc/auth_state.dart';
import 'package:hadith/features/settings/bloc/setting_bloc.dart';
import 'package:hadith/features/settings/bloc/setting_event.dart';
import 'package:hadith/features/settings/bloc/setting_state.dart';
import 'package:hadith/features/settings/loading_enum.dart';
import 'package:hadith/utils/loading_util.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

class AuthSettingBlocsConnect extends StatelessWidget {
  final Widget child;
  const AuthSettingBlocsConnect({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final settingBloc = context.read<SettingBloc>();

    return MultiBlocListener(
      child: child,
      listeners: [

        BlocListener<SettingBloc,SettingState>(
          listener: (context,state){
            if(state.message!=null){
              ToastUtils.showLongToast(state.message??"");
            }
          },
        ),
        BlocListener<AuthBloc,AuthState>(
          listenWhen: (prevState,nextState){
            if(prevState.user!=nextState.user){
              settingBloc.add(SettingEventRequestUserInfo(userId: nextState.user?.uid));
            }
            return true;
          },
          listener: (context,state){
            if(state.showDialogForDownloadBackup){
              showAlertDiaWithMultipleButton(context,
                  title: "Buluttaki yedeğinizi yüklemek ister misiniz?",
                  buttons: [
                    CustomButtonPositive(onTap: (){
                      Navigator.pop(context);
                      authBloc.add(AuthEventDownloadLastBackup());
                    },label: "En son Yedeği Yükle",),
                    CustomButtonPositive(onTap: (){
                      Navigator.pop(context);
                      showDownloadBackupDia(context);
                    },label: "Yedek dosyalarını göster",),
                    CustomButtonNegative(onTap: (){
                      authBloc.add(AuthEventDoNotShowDialog());
                      Navigator.pop(context);
                    },label: "Bir daha bu uyarıyı gösterme",),
                    CustomButtonNegative(onTap: () {
                      Navigator.pop(context);
                    },),
                  ]);
            }else if(state.askReUploadAutoBackup){
              showCustomAlertBottomDia(context,title: "Devam etmek istiyor musunuz",
                  content: "Yedekleme işlemi başarısız oldu. Çıkış yaparsanız verileriniz kaybolabilir",
                  btnApproved: ()async{
                    authBloc.add(AuthEventSignOut());
                  }
              );
            }else if(state.hasUploadAutoBackup){
              authBloc.add(AuthEventSignOut());
            }
            if(state.message!=null){
              ToastUtils.showLongToast(state.message??"");
            }
            if(state.loadingEnum == LoadingEnum.loading){
              LoadingUtil.requestLoading(context);
            }else if(state.loadingEnum == LoadingEnum.complete){
              LoadingUtil.requestCloseLoading(context);
            }
            if(state.refreshApp){
              Navigator.pop(context);
              Phoenix.rebirth(context);
            }
          },
        ),
      ],
    );
  }
}
