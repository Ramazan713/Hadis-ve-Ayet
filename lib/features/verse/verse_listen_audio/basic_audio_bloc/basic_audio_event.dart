
import 'package:equatable/equatable.dart';
import 'package:hadith/features/backup/backup_meta/bloc/backup_meta_event.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';

abstract class IBasicAudioEvent{}

class BasicAudioEventStartWithIdentifier extends IBasicAudioEvent{
  final String identifier;
  final AudioQualityEnum audioQuality;
  BasicAudioEventStartWithIdentifier({required this.identifier,required this.audioQuality});
}

class BasicAudioEventInit extends IBasicAudioEvent{}

class BasicAudioEventPause extends IBasicAudioEvent{}

class BasicAudioEventResume extends IBasicAudioEvent{}

class BasicAudioEventStopListening extends IBasicAudioEvent{}




