

import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';

abstract class IDownloadAudioEventOld extends Equatable{
  @override
  List<Object?> get props => [];
}


class DownloadAudioEventListen extends IDownloadAudioEventOld{}

class DownloadAudioEventStart extends IDownloadAudioEventOld{
  final Verse verse;
  final QuranAudioOption option;

  DownloadAudioEventStart(this.verse, this.option);
  @override
  List<Object?> get props => [verse,option];
}

class DownloadAudioEventResume extends IDownloadAudioEventOld{}

class DownloadAudioEventPause extends IDownloadAudioEventOld{}

class DownloadAudioEventCancel extends IDownloadAudioEventOld{}

class DownloadAudioEventRetry extends IDownloadAudioEventOld{}