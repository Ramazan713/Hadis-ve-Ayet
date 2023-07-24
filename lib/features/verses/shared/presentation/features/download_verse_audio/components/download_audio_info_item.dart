

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/presentation/components/custom_animated_switcher.dart';
import 'package:hadith/features/verses/shared/domain/enums/download_enum.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_state.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

import 'download_audio_progress_item.dart';

class DownloadAudioInfoItem extends StatelessWidget {
  const DownloadAudioInfoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadAudioBloc, DownloadAudioState>(
      builder: (context, state) {

        return CustomAnimatedSwitcher(
            firstChild: getContent(context, state),
            secondChild: const SizedBox(),
            showFirstChild: state.isActiveRunning
        );
      },
    );
  }

  Widget getContent(BuildContext context, DownloadAudioState state) {

    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DownloadAudioProgressItem(voiceState: state.serviceState),
            ),
            TextButton(
              onPressed: () {
                _showManageDownloadAudio(context);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "yönet",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}



void _showManageDownloadAudio(BuildContext context){
  final downloadBloc = context.read<DownloadAudioBloc>();

  Widget getButton(DownloadEnum? downloadEnum){
    if(downloadEnum == null) return const SizedBox();
    if(downloadEnum.isDownloading){
      return CustomButtonPositive(onTap: (){
        downloadBloc.add(DownloadAudioEventPause());
      }, label: "durdur",);

    } else if(downloadEnum.isPausing){
      return CustomButtonPositive(onTap: (){
        downloadBloc.add(DownloadAudioEventResume());
      }, label: "devam et",);

    }else if(downloadEnum.isRetry){
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
          listenWhen: (prevState,nextState){
            return prevState.downloadFinish != nextState.downloadFinish;
          },
          listener: (context,state){
            if(state.downloadFinish){
              Navigator.of(context).pop();
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
                        DownloadAudioProgressItem(voiceState: state.serviceState,),
                        const SizedBox(height: 10,),
                        Text(state.serviceState?.getBodyContent??"",style: Theme.of(context).textTheme.bodyMedium,),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getButton(state.downloadEnum),
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





