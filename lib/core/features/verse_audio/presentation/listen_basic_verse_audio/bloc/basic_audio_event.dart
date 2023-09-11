
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

class BasicAudioEventStartWithCustomVerseIds extends IBasicAudioEvent{
  final String? identifier;
  final List<int> verseIds;
  final AudioQualityEnum? audioQuality;
  final String? audioTag;

  BasicAudioEventStartWithCustomVerseIds({
    required this.verseIds,
    this.identifier,
    this.audioQuality,
    this.audioTag
  });
}

class BasicAudioEventClearMessage extends IBasicAudioEvent{}

class BasicAudioEventInit extends IBasicAudioEvent{}

class BasicAudioEventPause extends IBasicAudioEvent{}

class BasicAudioEventResume extends IBasicAudioEvent{}

class BasicAudioEventCancel extends IBasicAudioEvent{}


class BasicAudioEventChangeSpeed extends IBasicAudioEvent{
  final double newSpeed;
  BasicAudioEventChangeSpeed({required this.newSpeed});
}

class BasicAudioEventChangePosition extends IBasicAudioEvent{
  final Duration duration;
  BasicAudioEventChangePosition({required this.duration});
}

class BasicAudioEventSetLoop extends IBasicAudioEvent{
  final bool isLoop;
  BasicAudioEventSetLoop({required this.isLoop});
}

class BasicAudioEventToggleVisibilityAudioWidget extends IBasicAudioEvent{}




