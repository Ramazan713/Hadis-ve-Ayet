import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/listen_audio_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/basic_audio_request/basic_audio_request.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_state.dart';

class PlayBasicAudio extends StatelessWidget {
  final String identifier;
  final void Function() onPlay;

  const PlayBasicAudio({
    super.key,
    required this.identifier,
    required this.onPlay
  });


  Widget getPlayIcon({required Function() onPressed}){
    return IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.play_arrow));
  }

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<BasicAudioBloc>();
    return BlocSelector<BasicAudioBloc, BasicAudioState,_BasicAudioSelector>(
        selector: (state) => _BasicAudioSelector(
          activeIdentifier: state.activeIdentifier,
          audioEnum: state.audioEnum,
          isDownloading: state.isDownloading
        ),
        builder: (context, partialState) {

          final audioIdentifier = partialState.activeIdentifier;
          final audioEnum = partialState.audioEnum;

          if(audioIdentifier == identifier){
            if(partialState.isDownloading){
              return IconButton( icon: const Icon(Icons.downloading), onPressed: () {  },);
            }
            if(audioEnum == ListenAudioEnum.running){
              return IconButton(
                  onPressed: () {
                    audioBloc.add(BasicAudioEventPause());
                  },
                  icon: const Icon(Icons.pause));
            }else if(audioEnum == ListenAudioEnum.pause){
              return getPlayIcon(onPressed: (){
                audioBloc.add(BasicAudioEventResume());
              });
            }
          }

          return getPlayIcon(onPressed: onPlay);
        });
  }
}

class _BasicAudioSelector extends Equatable{
  final String? activeIdentifier;
  final ListenAudioEnum? audioEnum;
  final bool isDownloading;

  const _BasicAudioSelector({required this.activeIdentifier, required this.audioEnum,required this.isDownloading});

  @override
  List<Object?> get props => [activeIdentifier, audioEnum,isDownloading];
}