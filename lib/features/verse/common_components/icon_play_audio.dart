import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_event.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_state.dart';

class IconPlayAudio extends StatelessWidget {
  final String identifier;
  const IconPlayAudio({Key? key, required this.identifier}) : super(key: key);


  Widget getPlayIcon({required Function() onPressed}){
    return IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.play_arrow));
  }

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<BasicAudioBloc>();
    return BlocBuilder<BasicAudioBloc, BasicAudioState>(
        builder: (context, state) {

          final audioIdentifier = state.currentIdentifier;
          final audioEnum = state.getAudioEnum();

          if(identifier != audioIdentifier){
            return getPlayIcon(onPressed: (){
              audioBloc.add(BasicAudioEventStartWithIdentifier(identifier: identifier));
            });
          }

          if(state.isDownloading){
            return IconButton( icon: const Icon(Icons.downloading), onPressed: () {  },);
          }

          if(audioEnum == AudioEnum.running){
            return IconButton(
                onPressed: () {
                  audioBloc.add(BasicAudioEventPause());
                },
                icon: const Icon(Icons.pause));
          }
          return getPlayIcon(onPressed: (){
            audioBloc.add(BasicAudioEventResume());
          });
        });
  }
}
