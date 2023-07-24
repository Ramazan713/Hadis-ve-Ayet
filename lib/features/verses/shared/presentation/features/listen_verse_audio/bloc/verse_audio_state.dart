

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/audio_attribute_state.dart';
import 'package:hadith/features/verses/shared/domain/enums/listen_audio_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/listen_audio_dialog_event.dart';
import 'package:hadith/features/verses/shared/presentation/models/audio_param_builder.dart';

class ListenVerseAudioState extends Equatable{
  final ListenAudioServiceState? serviceState;
  final int? selectedSavePointId;
  final AudioParamBuilder audioParamBuilder;
  final String? message;
  final bool showAudioPlayerWidget;
  final bool followAudioText;
  final ListenAudioDialogEvent? dialogEvent;
  final ListenAudioParam? expectedListenParam;

  const ListenVerseAudioState({
    this.serviceState,
    this.message,
    required this.showAudioPlayerWidget,
    required this.followAudioText,
    this.selectedSavePointId,
    this.dialogEvent,
    required this.audioParamBuilder,
    this.expectedListenParam
  });

  ListenVerseAudioState copyWith({
    ListenAudioServiceState? serviceState,bool setServiceState=false,
    String?message,bool setMessage=false,
    bool?showAudioPlayerWidget,
    bool?followAudioText,
    int? selectedSavePointId, bool setSelectedSavePointId=false,
    ListenAudioDialogEvent? dialogEvent, bool setDialogEvent = false,
    AudioParamBuilder? audioParamBuilder,
    ListenAudioParam? expectedListenParam, bool setExpectedListenParam = false
  }){
    return ListenVerseAudioState(
        serviceState: setServiceState?serviceState:this.serviceState,
        message: setMessage?message:this.message,
        showAudioPlayerWidget: showAudioPlayerWidget??this.showAudioPlayerWidget,
        followAudioText: followAudioText??this.followAudioText,
        selectedSavePointId: setSelectedSavePointId?selectedSavePointId:this.selectedSavePointId,
        dialogEvent: setDialogEvent ? dialogEvent : this.dialogEvent,
        audioParamBuilder: audioParamBuilder ?? this.audioParamBuilder,
        expectedListenParam: setExpectedListenParam ? expectedListenParam : this.expectedListenParam
    );
  }

  ListenAudioEnum get audioEnum{
    return serviceState?.audioEnum ?? ListenAudioEnum.idle;
  }

  VerseMealVoiceModel? get audio => serviceState?.audio;

  int? get currentSavePointId{
    return selectedSavePointId;
  }

  bool get isActiveRunning{
    return [ListenAudioEnum.pause,ListenAudioEnum.running].contains(audioEnum);
  }

  String get currentAudioInfo{
    return "${audio?.surahName ?? ""} suresi ${audio?.verseNumbers ?? ""}.ayet çalıyor";
  }

  static ListenVerseAudioState init(){
    return const ListenVerseAudioState(
        showAudioPlayerWidget: false,
        followAudioText: true,
        audioParamBuilder: AudioParamBuilder()
    );
  }

  @override
  List<Object?> get props => [
    serviceState,message,
    showAudioPlayerWidget,followAudioText,
    selectedSavePointId, dialogEvent,audioParamBuilder,
    expectedListenParam
  ];
}