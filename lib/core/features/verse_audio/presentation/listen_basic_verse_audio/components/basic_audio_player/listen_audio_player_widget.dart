import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_state.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/components/basic_audio_player/audio_player_content_widget.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';

class BasicListenAudioPlayerWidget extends StatelessWidget {

  const BasicListenAudioPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BasicAudioBloc,BasicAudioState,bool>(
      selector: (state) => state.activeShowAudioPlayerWidget,
      builder: (context,showAudioPlayerWidget){
        return CustomAnimatedVisibility(
          visible: showAudioPlayerWidget,
          child: BasicAudioPlayerContentWidget()
        );
      }
    );
  }
}
