import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_state.dart';

class AudioInfoItem extends StatelessWidget {
  const AudioInfoItem({Key? key}) : super(key: key);


  Widget getContent(BuildContext context,String content){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 13),
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerseAudioBloc, VerseAudioState>(
      builder: (context, state) {
        final content = "${state.getAudio()?.surahName ?? ""} suresi ${state.getAudio()?.verseNumber ?? ""}.ayet çalıyor";

        return AnimatedSwitcher(
            switchInCurve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
            child: !state.showAudioPlayerWidget
                ? const SizedBox()
                : getContent(context,content));
      },
    );
  }
}
