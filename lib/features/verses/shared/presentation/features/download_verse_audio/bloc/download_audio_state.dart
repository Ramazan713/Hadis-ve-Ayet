import 'package:equatable/equatable.dart';
import 'package:hadith/features/verses/shared/domain/enums/download_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/verse_downloaded_model.dart';
import 'package:hadith/features/verses/shared/presentation/models/audio_param_builder.dart';

import 'download_audio_dialog_event.dart';

class DownloadAudioState extends Equatable {
  final DownloadAudioManagerState? serviceState;
  final AudioParamBuilder audioParamBuilder;
  final String? message;
  final DownloadAudioDialogEvent? dialogEvent;
  final DownloadAudioParam? lastDownloadedParam;


  bool get downloadFinish  => serviceState?.downloadEnum == DownloadEnum.successAll;

  const DownloadAudioState({
    this.serviceState,
    required this.audioParamBuilder,
    this.message,
    this.dialogEvent,
    this.lastDownloadedParam
  });

  DownloadAudioState copyWith({
    DownloadAudioManagerState? serviceState, bool setServiceState = false,
    String?message,bool setMessage=false,
    AudioParamBuilder? audioParamBuilder,
    DownloadAudioDialogEvent? dialogEvent, bool setDialogEvent = false,
    DownloadAudioParam? lastDownloadedParam, bool setLastDownloadedParam = false
  }){
    return DownloadAudioState(
        serviceState: setServiceState ? serviceState : this.serviceState,
        message: setMessage?message:this.message,
        audioParamBuilder: audioParamBuilder ?? this.audioParamBuilder,
        dialogEvent: setDialogEvent ? dialogEvent : this.dialogEvent,
        lastDownloadedParam: setLastDownloadedParam ? lastDownloadedParam : this.lastDownloadedParam
    );
  }

  VerseDownloadedVoiceModel?  get getVoiceModel => serviceState?.voiceModel;

  DownloadEnum? get downloadEnum => serviceState?.downloadEnum;

  bool get isActiveRunning => downloadEnum?.isActiveRunning ?? false;

  List<DownloadAudioParam> get queueParams => serviceState?.queueParams ?? [];

  static DownloadAudioState init(){
    return const DownloadAudioState(
      audioParamBuilder: AudioParamBuilder()
    );
  }


  @override
  List<Object?> get props => [serviceState,message,audioParamBuilder,dialogEvent,lastDownloadedParam];
}
