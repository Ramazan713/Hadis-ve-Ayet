

import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';

import '../listen_audio/listen_audio_param.dart';

sealed class BackgroundEvent{
  final String eventKey;
  BackgroundEvent({
    required this.eventKey,
  });
}


class BackgroundEventStartListenAudio extends BackgroundEvent{
  static const String key = "BackgroundEventStartListenAudio";

  final ListenAudioParam audioParam;
  BackgroundEventStartListenAudio({required this.audioParam}): super(eventKey: key);
}

class BackgroundEventStopListenAudio extends BackgroundEvent{
  static const String key = "BackgroundEventStopListenAudio";
  BackgroundEventStopListenAudio(): super(eventKey: key);
}

class BackgroundEventStartDownloadAudio extends BackgroundEvent{
  static const String key = "BackgroundEventStartDownloadAudio";

  final DownloadAudioParam audioDownloadParam;
  BackgroundEventStartDownloadAudio({required this.audioDownloadParam}): super(eventKey: key);
}

class BackgroundEventStopDownloadAudio extends BackgroundEvent{
  static const String key = "BackgroundEventStopDownloadAudio";
  BackgroundEventStopDownloadAudio(): super(eventKey: key);
}

class BackgroundEventStopAll extends BackgroundEvent{
  static const String key = "BackgroundEventStopAll";
  BackgroundEventStopAll(): super(eventKey: key);
}

class BackgroundEventCheckInitData extends BackgroundEvent{
  static const String key = "BackgroundEventCheckInitData";
  BackgroundEventCheckInitData(): super(eventKey: key);
}



