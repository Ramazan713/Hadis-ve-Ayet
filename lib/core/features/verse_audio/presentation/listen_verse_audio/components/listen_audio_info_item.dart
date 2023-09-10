import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_state.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';

class ListenAudioInfoItem extends StatelessWidget {
  const ListenAudioInfoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ListenVerseAudioBloc, ListenVerseAudioState>(
      builder: (context, state) {
        return CustomAnimatedSwitcher(
          firstChild: getContent(context, state.currentAudioInfo),
          secondChild: const SizedBox(),
          showFirstChild: state.showAudioPlayerWidget
        );
      },
    );
  }


  Widget getContent(BuildContext context,String content){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13)
          ),
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
}
