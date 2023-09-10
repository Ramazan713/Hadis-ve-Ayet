
sealed class AudioListenEvent{
  final String eventKey;
  AudioListenEvent({required this.eventKey});
}

class AudioListenEventResume extends AudioListenEvent{
  static const String key = "audioListenEventResume";
  AudioListenEventResume(): super(eventKey: key);
}

class AudioListenEventPause extends AudioListenEvent{
  static const String key = "audioListenEventPause";
  AudioListenEventPause(): super(eventKey: key);
}

class AudioListenEventSetPosition extends AudioListenEvent{
  static const String key = "audioListenEventSetPosition";
  final Duration duration;
  AudioListenEventSetPosition({required this.duration}): super(eventKey: key);
}


class AudioListenEventSetSpeed extends AudioListenEvent{
  static const String key = "audioListenEventSetSpeed";
  final double speed;
  AudioListenEventSetSpeed({required this.speed}): super(eventKey: key);
}

class AudioListenEventSetLoop extends AudioListenEvent{
  static const String key = "audioListenEventSetLoop";
  final bool loop;
  AudioListenEventSetLoop({required this.loop}): super(eventKey: key);
}

class AudioListenEventSetSavePoint extends AudioListenEvent{
  static const String key = "audioListenEventSetSavePoint";
  final int? savePointId;
  AudioListenEventSetSavePoint({required this.savePointId}): super(eventKey: key);
}