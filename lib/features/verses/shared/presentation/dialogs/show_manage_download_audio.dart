import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verses/shared/domain/enums/download_enum.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_state.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/components/download_audio_progress_item.dart';

void showManageDownloadAudio(BuildContext context){

  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context){
      return const Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 19),
        child: _DialogContent(),
      );
    }
  );
}


class _DialogContent extends StatelessWidget {
  const _DialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getListeners(
      child: SingleChildScrollView(
        child: BlocBuilder<DownloadAudioBloc,DownloadAudioState>(
          builder: (context,state){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 5),
              child: Column(
                children: [
                  getHeader(context),
                  const SizedBox(height: 13,),
                  Column(
                    children: [
                      DownloadAudioProgressItem(voiceState: state.serviceState,),
                      const SizedBox(height: 10,),
                      getInfoWidget(context, state),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  getBottomButtons(context,state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)
          ),
        ),
        Text(
          "Indirme yöneticisi",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget getInfoWidget(BuildContext context, DownloadAudioState state){
    return Text(
      state.serviceState?.getBodyContent??"",
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget getBottomButtons(BuildContext context, DownloadAudioState state){
    final downloadBloc = context.read<DownloadAudioBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: (){
              downloadBloc.add(DownloadAudioEventCancel());
              Navigator.of(context).pop();
            },
            child: const Text("Iptal et"),
          ),
          const SizedBox(width: 16,),
          getPrimaryButton(context,state.downloadEnum),
        ],
      ),
    );
  }

  Widget getPrimaryButton(BuildContext context, DownloadEnum? downloadEnum){
    final downloadBloc = context.read<DownloadAudioBloc>();

    if(downloadEnum == null) return const SizedBox();
    if(downloadEnum.isDownloading){
      return FilledButton(
        onPressed: (){
          downloadBloc.add(DownloadAudioEventPause());
        },
        child: const Text("Durdur"),
      );

    } else if(downloadEnum.isPausing){
      return FilledButton(
        onPressed: (){
          downloadBloc.add(DownloadAudioEventResume());
        },
        child: const Text("Devam et"),
      );

    }else if(downloadEnum.isRetry){
      return FilledButton(
        onPressed: (){
          downloadBloc.add(DownloadAudioEventRetry());
        },
        child: const Text("Tekrar dene"),
      );
    }
    return const SizedBox();
  }

  Widget getListeners({required Widget child}){
    return BlocListener<DownloadAudioBloc,DownloadAudioState>(
      listenWhen: (prevState,nextState){
        return prevState.downloadFinish != nextState.downloadFinish;
      },
      listener: (context,state){
        if(state.downloadFinish){
          Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }

}




