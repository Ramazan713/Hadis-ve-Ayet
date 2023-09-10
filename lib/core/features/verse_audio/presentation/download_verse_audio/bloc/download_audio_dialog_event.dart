

import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';

sealed class DownloadAudioDialogEvent{}

class DownloadAudioDialogEventRequestPermission extends DownloadAudioDialogEvent{}

class DownloadAudioDialogEventShowOption extends DownloadAudioDialogEvent{
  final SelectAudioOption selectAudioOption;
  DownloadAudioDialogEventShowOption({required this.selectAudioOption});
}