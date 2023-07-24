

import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/select_audio_option.dart';

sealed class ListenAudioDialogEvent{}

class ListenAudioDialogEventRequestPermission extends ListenAudioDialogEvent{}

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