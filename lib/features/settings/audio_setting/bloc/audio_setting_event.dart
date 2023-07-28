

abstract class IAudioSettingEventOld{}

class AudioSettingEventGetShared extends IAudioSettingEventOld{}

class AudioSettingEventInit extends IAudioSettingEventOld{}

class AudioSettingEventSetSpeed extends IAudioSettingEventOld{
  final double speed;
  AudioSettingEventSetSpeed({required this.speed});
}

class AudioSettingEventSetFollowAudio extends IAudioSettingEventOld{
  final bool audioFollowText;
  AudioSettingEventSetFollowAudio({required this.audioFollowText});
}
