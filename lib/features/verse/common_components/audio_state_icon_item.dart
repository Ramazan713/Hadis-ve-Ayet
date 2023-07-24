

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_state.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_state.dart';

class AudioStateIconItem<T> extends StatelessWidget {

  final T Function(DownloadAudioStateOld state)keyFuncDownload;
  final T Function(VerseAudioState state)keyFuncAudio;
  final Widget Function(bool isDownloadingActive,bool isAudioRunning) builder;
  final T value;

  const AudioStateIconItem({Key? key,required this.keyFuncDownload,required this.keyFuncAudio,
    required this.builder,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadAudioBlocOld,DownloadAudioStateOld>(
        buildWhen: (prevState,nextState){
          return (keyFuncDownload(prevState) != keyFuncDownload(nextState)) ||
              (prevState.voiceState.isActive() != nextState.voiceState.isActive());
        },
        builder: (context,downloadState){
          return BlocBuilder<VerseAudioBloc,VerseAudioState>(
              buildWhen: (prevState,nextState){
                return (keyFuncAudio(prevState) != keyFuncAudio(nextState)) ||
                    (prevState.isActive() != nextState.isActive());
              },
              builder: (context,audioState){
                final isDownloadingActive = value == keyFuncDownload(downloadState) && downloadState.voiceState.isActive();
                final isAudioRunning = value == keyFuncAudio(audioState) && audioState.isActive();
                return builder(isDownloadingActive,isAudioRunning);
              }
          );
        }
    );;
  }
}
