
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';

sealed class ListenAudioDialogEvent{}

class ListenAudioDialogEventRequestPermission extends ListenAudioDialogEvent{
  final bool showRationale;
  ListenAudioDialogEventRequestPermission({required this.showRationale});
}

class ListenAudioDialogEventShowOption extends ListenAudioDialogEvent{
  final SelectAudioOption selectAudioOption;
  ListenAudioDialogEventShowOption({required this.selectAudioOption});
}

class ListenAudioDialogEventInterruptAndReDownload extends ListenAudioDialogEvent{
  final DownloadAudioParam downloadParam;
  ListenAudioDialogEventInterruptAndReDownload({required this.downloadParam});
}

class ListenAudioDialogEventAskDownload extends ListenAudioDialogEvent{
  final DownloadAudioParam downloadParam;
  ListenAudioDialogEventAskDownload({required this.downloadParam});
}