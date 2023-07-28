import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verses/shared/domain/model/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/verse_downloaded_model.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_state.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_state.dart';

class VerseTopicAudioInfo<T> extends StatelessWidget {

  final T? Function(VerseDownloadedVoiceModel? state) selectDownloadState;
  final T? Function(VerseMealVoiceModel? state) selectListenState;
  final Widget Function(AudioInfoResultModel<T> info) builder;

  const VerseTopicAudioInfo({
    Key? key,
    required this.selectDownloadState,
    required this.selectListenState,
    required this.builder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadAudioBloc,DownloadAudioState>(
      buildWhen: (prevState, nextState){
        return prevState.isActiveRunning != nextState.isActiveRunning ||
            selectDownloadState(prevState.getVoiceModel) != selectDownloadState(nextState.getVoiceModel) ||
            prevState.queueParams != nextState.queueParams;
      },
      builder: (context, downloadState){
        return BlocBuilder<ListenVerseAudioBloc,ListenVerseAudioState>(
          buildWhen: (prevState, nextState){
            return prevState.isActiveRunning != nextState.isActiveRunning ||
                selectListenState(prevState.audio) != selectListenState(nextState.audio);
          },
          builder: (context, listenState){
            final info = AudioInfoResultModel<T>(
              listeningItem: selectListenState(listenState.audio),
              downloadingItem: selectDownloadState(downloadState.getVoiceModel),
              downloadingQueueItems: downloadState.queueParams.map((e) => e.itemIdForOption).toList()
            );

            return builder(info);
          },
        );
      },
    );
  }
}
