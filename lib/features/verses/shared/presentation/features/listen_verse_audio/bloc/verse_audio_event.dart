
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verse/common_models/verse_model.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/presentation/models/audio_param_builder.dart';

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
  ListenAudioEventStartListeningWithVerse({required this.verse});
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
