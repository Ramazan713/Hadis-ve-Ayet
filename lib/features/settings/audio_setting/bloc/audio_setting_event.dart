

import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';

abstract class IAudioSettingEvent{}

class AudioSettingEventGetShared extends IAudioSettingEvent{}


class AudioSettingEventInit extends IAudioSettingEvent{}

class AudioSettingEventSetQuality extends IAudioSettingEvent{
  final AudioQualityEnum audioQuality;
  AudioSettingEventSetQuality({required this.audioQuality});
}

class AudioSettingEventSetSpeed extends IAudioSettingEvent{
  final double speed;
  AudioSettingEventSetSpeed({required this.speed});
}

class AudioSettingEventSetFollowAudio extends IAudioSettingEvent{
  final bool audioFollowText;
  AudioSettingEventSetFollowAudio({required this.audioFollowText});
}
