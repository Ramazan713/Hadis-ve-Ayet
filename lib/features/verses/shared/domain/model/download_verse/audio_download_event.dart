

sealed class AudioDownloadEvent{
  final String eventKey;
  AudioDownloadEvent({required this.eventKey});
}

class AudioDownloadEventResume extends AudioDownloadEvent{
  static const String key = "audioDownloadEventResume";
  AudioDownloadEventResume(): super(eventKey: key);
}

class AudioDownloadEventPause extends AudioDownloadEvent{
  static const String key = "audioDownloadEventPause";
  AudioDownloadEventPause(): super(eventKey: key);
}


class AudioDownloadEventCancel extends AudioDownloadEvent{
  static const String key = "audioDownloadEventCancel";
  AudioDownloadEventCancel(): super(eventKey: key);
}

class AudioDownloadEventRetry extends AudioDownloadEvent{
  static const String key = "audioDownloadEventRetry";
  AudioDownloadEventRetry(): super(eventKey: key);
}

