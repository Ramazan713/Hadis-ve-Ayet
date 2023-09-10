import 'package:flutter/material.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/download_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/core/presentation/components/progress_content.dart';

class DownloadAudioProgressItem extends StatelessWidget {
  final DownloadAudioManagerState? voiceState;
  const DownloadAudioProgressItem({Key? key,required this.voiceState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(voiceState == null) {
      return const SizedBox();
    }
    return ProgressRateContent(
      rate: voiceState?.getProgressPercentage,
      description: voiceState?.downloadEnum.description
    );
  }
}