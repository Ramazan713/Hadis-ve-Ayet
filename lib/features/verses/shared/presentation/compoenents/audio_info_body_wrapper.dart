import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/components/download_audio_info_item.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/components/listen_audio_info_item.dart';

import '../features/listen_verse_audio/components/audio_player/listen_audio_player_widget.dart';

class AudioInfoBodyWrapper extends StatelessWidget {
  final Widget child;
  final SavePointDestination destination;

  const AudioInfoBodyWrapper({
    Key? key,
    required this.child,
    required this.destination
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        context.read<ListenVerseAudioBloc>()
            .add(ListenAudioEventToggleVisibilityAudioWidget());
      },
      child: Column(
        children: [
          const ListenAudioInfoItem(),
          const SizedBox(height: 4,),
          const DownloadAudioInfoItem(),
          Expanded(child: child),
          ListenAudioPlayerWidget(
            destination: destination,
          )
        ],
      ),
    );
  }
}
