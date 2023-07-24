import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/common_dialogs/show_manage_download_audio.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_state.dart';

import 'download_audio_progress_item.dart';

class DownloadAudioInfoItem extends StatelessWidget {
  const DownloadAudioInfoItem({Key? key}) : super(key: key);

  Widget getContent(BuildContext context, DownloadAudioStateOld state) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DownloadAudioProgressItem(voiceState: state.voiceState),
            ),
            TextButton(
              onPressed: () {
                showManageDownloadAudio(context);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadAudioBlocOld, DownloadAudioStateOld>(
      builder: (context, state) {
        return AnimatedSwitcher(
            switchInCurve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
            child: !state.voiceState.isActive()
                ? const SizedBox()
                : getContent(context, state));
      },
    );
  }
}
