import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/common_components/download_audio_progress_item.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_state.dart';
import 'package:hadith/features/verse/verse_download_audio/constants/download_enum.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';




void showManageDownloadAudio(BuildContext context){
  final downloadBloc = context.read<DownloadAudioBloc>();

  Widget getButton(DownloadEnum downloadEnum){
    if(downloadEnum == DownloadEnum.downloading){
      return CustomButtonPositive(onTap: (){
        downloadBloc.add(DownloadAudioEventPause());
      }, label: "durdur",);
    }else if(downloadEnum == DownloadEnum.pause){
      return CustomButtonPositive(onTap: (){
        downloadBloc.add(DownloadAudioEventResume());
      }, label: "devam et",);
    }else if(downloadEnum == DownloadEnum.retry){
      return CustomButtonPositive(onTap: (){
        downloadBloc.add(DownloadAudioEventRetry());
      },label: "tekrar dene",);
    }
    return const SizedBox();
  }

  showDialog(
      context: context,
      builder: (context){
        return BlocListener<DownloadAudioBloc,DownloadAudioState>(
          listener: (context,state){
            if(state.downloadFinish){
              Navigator.pop(context);
            }
          },
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 19),
            child: SingleChildScrollView(
              child: BlocBuilder<DownloadAudioBloc,DownloadAudioState>(
                builder: (context,state){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.topRight,child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.close)),),
                        Text("indirme yöneticisi",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleLarge,),
                        const SizedBox(height: 13,),
                        DownloadAudioProgressItem(voiceState: state.voiceState,),
                        const SizedBox(height: 10,),
                        Text(state.voiceState.getBodyContent()),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getButton(state.voiceState.downloadEnum),
                            CustomButtonNegative(onTap: (){
                              downloadBloc.add(DownloadAudioEventCancel());
                              Navigator.of(context).pop();
                            }, label: "iptal et",)
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }
  );

}