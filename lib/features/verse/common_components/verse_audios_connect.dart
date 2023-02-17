import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_state.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_event.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_state.dart';
import 'package:hadith/features/verse/verse_listen_audio/dialogs/show_voice_options.dart';
import 'package:hadith/utils/i_notification.dart';
import 'package:hadith/utils/snack_utils.dart';


class VerseAudiosConnect extends StatelessWidget {
  final Widget child;
  const VerseAudiosConnect({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<VerseAudioBloc>();
    final downloadBloc = context.read<DownloadAudioBloc>();
    return MultiBlocListener(
        listeners: [
          BlocListener<VerseAudioBloc,VerseAudioState>(
            listener: (context,state)async{
              if(state.askNotificationPermission){
                await INotification.requestPermission();
              }else if(state.askInterruptAndDownload){
                showCustomAlertBottomDia(
                    context,
                    title: "Şuanda ses oynatıcısı zaten çalıyor",
                    content: "ses oynatıcısını yarıda kesip, indirme yapmak istiyor musunuz?",
                    btnApproved: ()async{
                      final verseModel = state.tempModel;
                      final option = state.tempOption;
                      if(verseModel!=null && option!=null){
                        audioBloc.add(AudioEventStop());
                        await Future.delayed(const Duration(seconds: kDelayForStartingServiceInSeconds));
                        downloadBloc.add(DownloadAudioEventStart(verseModel.item,option));
                      }
                    }
                );
              }
              else if(state.showAudioOption){
                showVoiceOptions(context,onTap: (option){
                  audioBloc.add(AudioEventRequestListening(voiceOption: option));
                },originTag: state.originTag);
              }else if(state.askDownload){
                showCustomAlertBottomDia(
                    context,
                    title: "veri bulunamadı",
                    content: "Dinlemek istediğniz ayetler bulunamadı. Indirmek ister misiniz?",
                    btnApproved: (){
                      final verseModel = state.tempModel;
                      final option = state.tempOption;
                      if(verseModel!=null && option!=null){
                        downloadBloc.add(DownloadAudioEventStart(verseModel.item,option));
                      }
                    }
                );
              }

              if(state.message!=null){
                SnackUtils.showMessage(context, SnackBar(content: Text(state.message??"")));
              }
            },
          ),
          BlocListener<DownloadAudioBloc,DownloadAudioState>(
            listener: (context,state){
              if(state.downloadFinish){
                audioBloc.add(AudioEventRequestListening(isAfterDownloading: true));
              }
              if(state.message!=null){
                SnackUtils.showMessage(context, SnackBar(content: Text(state.message??"")));
              }
            },
          )
        ],
        child: child
    );
  }
}
