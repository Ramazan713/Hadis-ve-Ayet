

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/verse_audio_model.dart';
import 'package:hadith/features/verses/shared/domain/enums/listen_audio_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_service_state.dart';

class BasicAudioState extends Equatable{
  final ListenAudioServiceState? audioServiceState;
  final String? activeIdentifier;
  final String? message;
  final bool isDownloading;

  const BasicAudioState({
    this.audioServiceState,
    this.message,
    required this.isDownloading,
    this.activeIdentifier
  });

  BasicAudioState copyWith({
    ListenAudioServiceState? audioServiceState, bool setAudioServiceState=false,
    String? message, bool setMessage=false,
    String? activeIdentifier, bool setActiveIdentifier = false,
    bool? isDownloading,
  }){
    return BasicAudioState(
        audioServiceState: setAudioServiceState ? audioServiceState : this.audioServiceState,
        message: setMessage ? message : this.message,
        isDownloading: isDownloading ?? this.isDownloading,
        activeIdentifier: setActiveIdentifier ? activeIdentifier : this.activeIdentifier
    );
  }

  static BasicAudioState init(){
    return const BasicAudioState(
        isDownloading:false,
    );
  }

  ListenAudioEnum? get audioEnum{
    return audioServiceState?.audioEnum;
  }

  @override
  List<Object?> get props => [audioServiceState,message,isDownloading,activeIdentifier];
}