

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_state.dart';
import 'package:hadith/core/presentation/dialogs/show_manage_download_audio.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';
import 'download_audio_progress_item.dart';

class DownloadAudioInfoItem extends StatelessWidget {
  final EdgeInsets? margins;

  const DownloadAudioInfoItem({
    Key? key,
    this.margins
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadAudioBloc, DownloadAudioState>(
      builder: (context, state) {
        return CustomAnimatedSwitcher(
            firstChild: getContent(context, state),
            secondChild: const SizedBox(),
            showFirstChild: state.isActiveRunning
        );
      },
    );
  }

  Widget getContent(BuildContext context, DownloadAudioState state) {

    return Card(
      margin: margins ?? const EdgeInsets.symmetric(horizontal: 1,vertical: 1),
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DownloadAudioProgressItem(voiceState: state.serviceState),
            ),
            TextButton(
              onPressed: () {
                showManageDownloadAudio(context);
              },
              child: Text(
                "yönet",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}





