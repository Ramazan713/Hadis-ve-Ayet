import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dialog.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/notification/i_verse_listen_audio_notification.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/download_audio_listener_connect.dart';
import 'package:hadith/features/verses/shared/presentation/dialogs/show_voice_options.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/listen_audio_dialog_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_state.dart';
import 'package:hadith/utils/toast_utils.dart';

class AudioConnect extends StatelessWidget {
  final Widget child;

  const AudioConnect({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<ListenVerseAudioBloc>();
    final downloadBloc = context.read<DownloadAudioBloc>();

    return DownloadAudioListenerConnect(
      sendEventToAudioPlayerAfterDownloaded: true,
      child: MultiBlocListener(
          listeners: [
            BlocListener<ListenVerseAudioBloc,ListenVerseAudioState>(
              listenWhen: (prevState,nextState){
                return prevState.message != nextState.message;
              },
              listener: (context, state){
                final message = state.message;

                if(message!=null){
                  ToastUtils.showLongToast(message);
                  audioBloc.add(ListenAudioEventClearMessage());
                }
              },
            ),
            BlocListener<ListenVerseAudioBloc,ListenVerseAudioState>(
              listenWhen: (prevState,nextState){
                return prevState.dialogEvent != nextState.dialogEvent;
              },
              listener: (context, state) async{
                final dialogEvent = state.dialogEvent;

                if(dialogEvent!=null){
                  audioBloc.add(ListenAudioEventClearDialogEvent());
                  print("PermissionCheckStatus dialog: $dialogEvent");
                  switch(dialogEvent){
                    case ListenAudioDialogEventShowOption _:
                      showVoiceOptions(
                          context,
                          audioServiceEnum: AudioServiceEnum.listenAudio,
                          selectOp: dialogEvent.selectAudioOption,
                          onTap: (option){
                            audioBloc.add(ListenAudioEventHandleOption(op: option));
                          }
                      );
                      break;
                    case ListenAudioDialogEventAskDownload _:
                      showCustomAlertBottomDia(context,
                          title: "veri bulunamadı",
                          content: "Dinlemek istediğniz ayetler bulunamadı. Indirmek ister misiniz?",
                          btnApproved: (){
                            downloadBloc.add(DownloadAudioEventStartDownloadingWithParam(downloadParam: dialogEvent.downloadParam));
                          }
                      );
                      break;
                    case ListenAudioDialogEventRequestPermission _:
                      showCustomAlertDialog(
                        context,
                        title: "Bildirim için izin gerekli",
                        content: "ses oynatıcısını yönetmek ve durum bilgisini görmek için gerekebilir",
                        positiveLabel: "Ayarlara Git",
                        btnApproved: ()async{
                          await IVerseListenAudioNotification.requestNotificationPermission();
                        }
                      );
                      break;
                    case ListenAudioDialogEventInterruptAndReDownload _:
                      showCustomAlertBottomDia(
                          context,
                          title: "Şuanda ses oynatıcısı zaten çalıyor",
                          content: "ses oynatıcısını yarıda kesip, indirme yapmak istiyor musunuz?",
                          btnApproved: ()async{
                            downloadBloc.add(DownloadAudioEventStartDownloadingWithParam(downloadParam: dialogEvent.downloadParam));
                            audioBloc.add(ListenAudioEventStop());
                            ToastUtils.showLongToast("indirme işleminden sonra ses oynatıcısı devam edicektir");
                          }
                      );
                      break;
                  }
                }
              },
            ),
          ],
          child: child
      ),
    );
  }
}
