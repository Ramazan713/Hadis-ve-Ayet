
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/audio_param_builder.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';

abstract class IListenVerseAudioEvent{}

class ListenAudioEventStateListener extends IListenVerseAudioEvent{}

class ListenAudioEventCancelServiceListener extends IListenVerseAudioEvent{}

class ListenAudioEventAppPreferenceListener extends IListenVerseAudioEvent{}


class ListenAudioEventSelectedSavePointListener extends IListenVerseAudioEvent{}

class ListenAudioEventHandleAfterDownloading extends IListenVerseAudioEvent{
  final ListenAudioParam listenAudioParam;
  ListenAudioEventHandleAfterDownloading({required this.listenAudioParam});
}

class ListenAudioEventStartListeningWithVerse extends IListenVerseAudioEvent{
  final Verse verse;
  final SelectAudioOption? selectAudioOption;

  ListenAudioEventStartListeningWithVerse({
    required this.verse,
    this.selectAudioOption
  });
}

class ListenAudioEventListeningBuilder extends IListenVerseAudioEvent{}

class ListenAudioEventStartListeningWithParam extends IListenVerseAudioEvent{
  final AudioParamBuilder paramBuilder;
  ListenAudioEventStartListeningWithParam({required this.paramBuilder});
}

class ListenAudioEventHandleOption extends IListenVerseAudioEvent{
  final QuranAudioOption op;
  ListenAudioEventHandleOption({required this.op});
}

class ListenAudioEventClearMessage extends IListenVerseAudioEvent{}

class ListenAudioEventClearDialogEvent extends IListenVerseAudioEvent{}


class ListenAudioEventResume extends IListenVerseAudioEvent{}

class ListenAudioEventSetSavePointId extends IListenVerseAudioEvent{
  final int? savepointId;
  ListenAudioEventSetSavePointId({required this.savepointId});
}

class ListenAudioEventPause extends IListenVerseAudioEvent{}

class ListenAudioEventStop extends IListenVerseAudioEvent{}

class ListenAudioEventChangeSpeed extends IListenVerseAudioEvent{
  final double newSpeed;
  ListenAudioEventChangeSpeed({required this.newSpeed});

}

class ListenAudioEventChangePosition extends IListenVerseAudioEvent{
  final Duration duration;
  ListenAudioEventChangePosition({required this.duration});

}

class ListenAudioEventSetLoop extends IListenVerseAudioEvent{
  final bool isLoop;
  ListenAudioEventSetLoop({required this.isLoop});
}

class ListenAudioEventToggleVisibilityAudioWidget extends IListenVerseAudioEvent{}
