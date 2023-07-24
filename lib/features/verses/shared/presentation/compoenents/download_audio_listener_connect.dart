import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dialog.dart';
import 'package:hadith/features/verses/shared/data/mapper/param_mapper.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/notification/i_verse_download_audio_notification.dart';
import 'package:hadith/features/verses/shared/presentation/dialogs/show_voice_options.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_dialog_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_state.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/utils/toast_utils.dart';

class DownloadAudioListenerConnect extends StatelessWidget {
  final Widget child;
  final bool sendEventToAudioPlayerAfterDownloaded;

  const DownloadAudioListenerConnect({
    Key? key,
    required this.child,
    this.sendEventToAudioPlayerAfterDownloaded = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final downloadBloc = context.read<DownloadAudioBloc>();
    final audioBloc = context.read<ListenVerseAudioBloc>();

    return MultiBlocListener(
        listeners:[
          BlocListener<DownloadAudioBloc,DownloadAudioState>(
            listenWhen: (prevState, nextState){
              return prevState.lastDownloadedParam != nextState.lastDownloadedParam ||
                  prevState.message != nextState.message;
            },
            listener: (context, state){
              final message = state.message;
              if(message!=null){
                ToastUtils.showLongToast(message);
                downloadBloc.add(DownloadAudioEventClearMessage());
              }

              final lastDownloaded = state.lastDownloadedParam;
              if(sendEventToAudioPlayerAfterDownloaded && lastDownloaded!=null){
                downloadBloc.add(DownloadAudioEventClearLastDownloadedParam());
                audioBloc.add(ListenAudioEventHandleAfterDownloading(
                    listenAudioParam: lastDownloaded.toListenAudioParam()
                ));
              }

            }
          ),
          BlocListener<DownloadAudioBloc,DownloadAudioState>(
              listenWhen: (prevState, nextState){
                return prevState.dialogEvent != nextState.dialogEvent;
              },
              listener: (context, state){
                final dialogEvent = state.dialogEvent;

                if(dialogEvent!=null){
                  downloadBloc.add(DownloadAudioEventClearDialogEvent());
                  switch(dialogEvent){
                    case DownloadAudioDialogEventShowOption _:
                      showVoiceOptions(
                          context,
                          selectOp: dialogEvent.selectAudioOption,
                          audioServiceEnum: AudioServiceEnum.downloadAudio,
                          onTap: (option){
                            downloadBloc.add(DownloadAudioEventHandleOption(op: option));
                          }
                      );
                      break;
                    case DownloadAudioDialogEventRequestPermission _:
                      showCustomAlertDialog(
                          context,
                          title: "Bildirim için izin gerekli",
                          content: "indirmeyi yönetme ve durum bilgisini görmek için gerekebilir",
                          positiveLabel: "Ayarlara Git",
                          btnApproved: ()async{
                            await IVerseDownloadAudioNotification.requestNotificationPermission();
                          }
                      );
                      break;
                  }
                }
              }
          )
        ],
        child: child
    );
  }
}
