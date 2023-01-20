
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/common_components/verse_audio_item.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_state.dart';


class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocSelector<VerseAudioBloc,VerseAudioState,bool>(
        selector: (state)=>state.showAudioPlayerWidget,
        builder: (context,isActive){
          return AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              duration: const Duration(milliseconds: 300),
              child:
              !isActive ? const SizedBox() : VerseAudioItem());
        }
    );
  }
}
