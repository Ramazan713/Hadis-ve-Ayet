

import 'package:equatable/equatable.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/listen_audio_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_service_state.dart';



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'basic_audio_state.freezed.dart';

@freezed
class BasicAudioState with _$BasicAudioState{
  const BasicAudioState._();

  const factory BasicAudioState({
    required bool isDownloading,
    required bool showAudioPlayerWidget,
    ListenAudioServiceState? audioServiceState,
    String? activeIdentifier,
    String? message,
    String? audioTag
  }) = _BasicAudioState;

  static BasicAudioState init(){
    return const BasicAudioState(
      isDownloading: false,
      showAudioPlayerWidget: false
    );
  }

  ListenAudioEnum get audioEnum{
    return audioServiceState?.audioEnum ?? ListenAudioEnum.idle;
  }

  bool get isActiveRunning{
    return [ListenAudioEnum.pause,ListenAudioEnum.running].contains(audioEnum);
  }

  String? get activeAudioTag => isActiveRunning ? audioTag : null;

  bool get activeShowAudioPlayerWidget => isActiveRunning ? showAudioPlayerWidget : false;
}