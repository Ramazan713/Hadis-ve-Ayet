import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/components/download_audio_info_item.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/components/basic_audio_player/listen_audio_player_widget.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/components/audio_player/listen_audio_player_widget.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/components/listen_audio_info_item.dart';

import '../bloc/basic_audio_state.dart';

class BasicAudioInfoBodyWrapper extends StatefulWidget {
  final Widget child;

  const BasicAudioInfoBodyWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<BasicAudioInfoBodyWrapper> createState() => _BasicAudioInfoBodyWrapperState();
}

class _BasicAudioInfoBodyWrapperState extends State<BasicAudioInfoBodyWrapper> {

  late final BasicAudioBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<BasicAudioBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: () {
        bloc.add(BasicAudioEventPause());
      },
      child: GestureDetector(
        onTap: (){
          bloc.add(BasicAudioEventToggleVisibilityAudioWidget());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getDownloadingItem(),
            Expanded(child: widget.child),
            const BasicListenAudioPlayerWidget()
          ],
        ),
      ),
    );
  }

  Widget getDownloadingItem(){
    return BlocSelector<BasicAudioBloc, BasicAudioState, bool>(
      selector: (state) => state.isDownloading,
      builder: (context, isDownloading){
        if(!isDownloading) return const SizedBox.shrink();
        return Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 7),
            child: Text(
              "İndiriliyor",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    bloc.add(BasicAudioEventCancel());
    super.dispose();
  }
}
