
import 'package:equatable/equatable.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verse/common_models/verse_model.dart';

abstract class IVerseAudioEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class AudioEventInit extends IVerseAudioEvent{}

class AudioEventInit2 extends IVerseAudioEvent{}


class AudioEventRequestOption extends IVerseAudioEvent{
  final VerseModel verseModel;
  final OriginTag originTag;
  AudioEventRequestOption({required this.verseModel,required this.originTag});

  @override
  List<Object?> get props => [verseModel,originTag];
}

class AudioEventRequestListening extends IVerseAudioEvent{
  final QuranAudioOption? voiceOption;
  final bool isAfterDownloading;
  AudioEventRequestListening({this.voiceOption,this.isAfterDownloading=false});

  @override
  List<Object?> get props => [voiceOption,isAfterDownloading];
}

class AudioEventResume extends IVerseAudioEvent{}

class AudioEventPause extends IVerseAudioEvent{}

class AudioEventStop extends IVerseAudioEvent{}

class AudioEventChangeSpeed extends IVerseAudioEvent{
  final double newSpeed;
  AudioEventChangeSpeed({required this.newSpeed});

  @override
  List<Object?> get props => [newSpeed];
}

class AudioEventChangePosition extends IVerseAudioEvent{
  final Duration duration;
  AudioEventChangePosition({required this.duration});

  @override
  List<Object?> get props => [duration];
}

class AudioEventSetLoop extends IVerseAudioEvent{
  final bool isLoop;
  AudioEventSetLoop({required this.isLoop});

  @override
  List<Object?> get props => [isLoop];
}

class AudioEventChangeVisibilityAudioWidget extends IVerseAudioEvent{}
