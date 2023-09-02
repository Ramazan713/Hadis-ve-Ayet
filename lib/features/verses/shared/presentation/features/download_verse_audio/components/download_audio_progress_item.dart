import 'package:flutter/material.dart';
import 'package:hadith/features/verses/shared/domain/enums/download_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_manager_state.dart';



class DownloadAudioProgressItem extends StatelessWidget {
  final DownloadAudioManagerState? voiceState;
  const DownloadAudioProgressItem({Key? key,required this.voiceState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(voiceState == null) {
      return const SizedBox();
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        LinearProgressIndicator(
          value: voiceState?.getProgressPercentage,
          minHeight: 20,
        ),
        Text("%${voiceState?.getProgress100} (${voiceState?.downloadEnum.description})",
          textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,)
      ],
    );
  }
}