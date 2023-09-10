
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/features/backup/backup_meta/bloc/backup_meta_event.dart';

abstract class IBasicAudioEvent{}

class BasicAudioEventStartWithIdentifier extends IBasicAudioEvent{
  final String identifier;
  final int verseId;
  final AudioQualityEnum? audioQuality;

  BasicAudioEventStartWithIdentifier({
    required this.identifier,
    this.verseId = 1,
    this.audioQuality
  });
}

class BasicAudioEventClearMessage extends IBasicAudioEvent{}

class BasicAudioEventInit extends IBasicAudioEvent{}

class BasicAudioEventPause extends IBasicAudioEvent{}

class BasicAudioEventResume extends IBasicAudioEvent{}

class BasicAudioEventStopListening extends IBasicAudioEvent{}




