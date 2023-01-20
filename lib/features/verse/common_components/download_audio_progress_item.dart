import 'package:flutter/material.dart';
import 'package:hadith/features/verse/verse_download_audio/constants/download_enum.dart';
import 'package:hadith/features/verse/verse_download_audio/models/download_voice_service_state.dart';



class DownloadAudioProgressItem extends StatelessWidget {
  final DownloadVoiceServiceState voiceState;
  const DownloadAudioProgressItem({Key? key,required this.voiceState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        LinearProgressIndicator(value: voiceState.getProgress100().toDouble()/100,
            minHeight: 20),
        Text("%${voiceState.getProgress100()} (${voiceState.downloadEnum.description})",
          textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,)
      ],
    );
  }
}