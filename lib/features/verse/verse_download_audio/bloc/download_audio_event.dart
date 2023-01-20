

import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';

abstract class IDownloadAudioEvent extends Equatable{
  @override
  List<Object?> get props => [];
}


class DownloadAudioEventListen extends IDownloadAudioEvent{}

class DownloadAudioEventStart extends IDownloadAudioEvent{
  final Verse verse;
  final QuranAudioOption option;

  DownloadAudioEventStart(this.verse, this.option);
  @override
  List<Object?> get props => [verse,option];
}

class DownloadAudioEventResume extends IDownloadAudioEvent{}

class DownloadAudioEventPause extends IDownloadAudioEvent{}

class DownloadAudioEventCancel extends IDownloadAudioEvent{}

class DownloadAudioEventRetry extends IDownloadAudioEvent{}