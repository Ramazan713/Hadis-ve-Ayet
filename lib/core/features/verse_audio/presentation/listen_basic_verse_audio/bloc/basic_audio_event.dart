
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/basic_audio_request/basic_audio_request.dart';

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

class BasicAudioEventRequestAudio extends IBasicAudioEvent{
  final String identifier;
  final BasicAudioRequest request;
  final AudioQualityEnum audioQuality;

  BasicAudioEventRequestAudio({
    required this.identifier,
    required this.request,
    required this.audioQuality
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




