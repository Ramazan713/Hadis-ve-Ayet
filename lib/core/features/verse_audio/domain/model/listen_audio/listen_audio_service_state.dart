

import 'package:hadith/core/features/verse_audio/domain/enums/listen_audio_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'listen_audio_service_state.g.dart';

@JsonSerializable(explicitToJson: true)
class ListenAudioServiceState extends Equatable{
  final VerseMealVoiceModel? audio;
  final String?error;
  final ListenAudioEnum audioEnum;
  final Duration duration;
  final Duration position;
  final double speed;
  final bool isLoop;

  const ListenAudioServiceState({
    this.audio,
    required this.audioEnum,
    required this.duration,
    required this.position,
    required this.speed,
    required this.isLoop,
    this.error,
  });

  ListenAudioServiceState copyWith({
    ListenAudioEnum? audioEnum,
    VerseMealVoiceModel? audio,bool setAudio=false,
    Duration?duration,
    Duration?position,
    double? speed,
    bool?isLoop,
    String?error,bool setError=false,
  }){
    return ListenAudioServiceState(
        audioEnum: audioEnum ?? this.audioEnum,
        audio: setAudio ? audio : this.audio,
        duration: duration ?? this.duration,
        position: position ?? this.position,
        speed: speed ?? this.speed,
        isLoop: isLoop ?? this.isLoop,
        error: setError ? error : this.error,
    );
  }

  static ListenAudioServiceState init(){
    return const ListenAudioServiceState(
        audioEnum: ListenAudioEnum.idle,
        duration: Duration(),
        position: Duration(),
        speed: 1,
        isLoop: false
    );
  }

  String getInfo(){
    return "${audio?.editionName} - ${audio?.surahName} ${audio?.verseNumbers}";
  }

  bool isDistinctForNotification(ListenAudioServiceState otherAudio){
    return (audioEnum == otherAudio.audioEnum) && (audio?.surahId == otherAudio.audio?.surahId) &&
        (audio?.verseNumbers == otherAudio.audio?.verseNumbers);
  }

  factory ListenAudioServiceState.fromJson(Map<String, dynamic> json) => _$ListenAudioServiceStateFromJson(json);

  Map<String, dynamic> toJson() => _$ListenAudioServiceStateToJson(this);


  @override
  List<Object?> get props => [audioEnum,audio,duration,position,isLoop,speed,error];
}