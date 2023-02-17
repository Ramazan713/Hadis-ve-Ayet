

abstract class IAudioSettingEvent{}

class AudioSettingEventGetShared extends IAudioSettingEvent{}

class AudioSettingEventInit extends IAudioSettingEvent{}

class AudioSettingEventSetSpeed extends IAudioSettingEvent{
  final double speed;
  AudioSettingEventSetSpeed({required this.speed});
}

class AudioSettingEventSetFollowAudio extends IAudioSettingEvent{
  final bool audioFollowText;
  AudioSettingEventSetFollowAudio({required this.audioFollowText});
}
