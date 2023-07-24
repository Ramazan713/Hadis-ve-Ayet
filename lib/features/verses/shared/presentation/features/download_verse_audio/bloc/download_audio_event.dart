
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/features/verses/shared/presentation/models/audio_param_builder.dart';

abstract class IDownloadAudioEvent{}


class DownloadAudioEventListener extends IDownloadAudioEvent{}

class DownloadAudioEventCancelServiceListener extends IDownloadAudioEvent{}


class DownloadAudioEventDownloadBuilder extends IDownloadAudioEvent{}

class DownloadAudioEventStartDownloadingWithVerse extends IDownloadAudioEvent{
  final Verse verse;
  DownloadAudioEventStartDownloadingWithVerse({required this.verse});
}

class DownloadAudioEventStartDownloadingWithBuilder extends IDownloadAudioEvent{
  final AudioParamBuilder paramBuilder;
  DownloadAudioEventStartDownloadingWithBuilder({required this.paramBuilder});
}

class DownloadAudioEventStartDownloadingWithParam extends IDownloadAudioEvent{
  final DownloadAudioParam downloadParam;
  DownloadAudioEventStartDownloadingWithParam({required this.downloadParam});
}

class DownloadAudioEventHandleOption extends IDownloadAudioEvent{
  final QuranAudioOption op;
  DownloadAudioEventHandleOption({required this.op});
}

class DownloadAudioEventClearLastDownloadedParam extends IDownloadAudioEvent{}

class DownloadAudioEventClearDialogEvent extends IDownloadAudioEvent{}

class DownloadAudioEventClearMessage extends IDownloadAudioEvent{}

class DownloadAudioEventResume extends IDownloadAudioEvent{}

class DownloadAudioEventPause extends IDownloadAudioEvent{}

class DownloadAudioEventCancel extends IDownloadAudioEvent{}

class DownloadAudioEventRetry extends IDownloadAudioEvent{}