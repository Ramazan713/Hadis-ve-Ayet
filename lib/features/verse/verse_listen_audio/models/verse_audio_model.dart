

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verse_audio_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VerseAudioModel extends Equatable{
  final VerseAudioEntityOld? audio;
  final String?error;
  final AudioEnum audioEnum;
  final Duration duration;
  final Duration position;
  final double speed;
  final bool isLoop;
  final int currentIndex;
  final int initIndex;

  const VerseAudioModel({this.audio, required this.audioEnum,required this.duration,required this.initIndex,
    required this.position,required this.speed,required this.isLoop,this.error,required this.currentIndex});

  VerseAudioModel copyWith({AudioEnum? audioEnum,VerseAudioEntityOld? audio,bool setModel=false,Duration?duration,
  Duration?position,double? speed,bool?isLoop,String?error,bool setError=false,int?currentIndex,int?initIndex}){
    return VerseAudioModel(
        audioEnum: audioEnum??this.audioEnum,
        audio: setModel?audio:this.audio,
        duration: duration??this.duration,
        position: position??this.position,
        speed: speed??this.speed,
        isLoop: isLoop??this.isLoop,
        error: setError?error:this.error,
        currentIndex: currentIndex??this.currentIndex,
        initIndex: initIndex??this.initIndex
    );
  }

  static VerseAudioModel init(){
    return const VerseAudioModel(audioEnum: AudioEnum.idle,currentIndex: -1,initIndex:0,
        duration: Duration(),position: Duration(),speed: 1,isLoop: false);
  }

  String getInfo(){
    return "${audio?.editionName} - ${audio?.surahName} ${audio?.verseNumber}";
  }

  bool isDistinctForNotification(VerseAudioModel otherAudio){
    return (audioEnum == otherAudio.audioEnum) && (audio?.surahId == otherAudio.audio?.surahId) &&
        (audio?.verseNumber == otherAudio.audio?.verseNumber);
  }

  factory VerseAudioModel.fromJson(Map<String, dynamic> json) => _$VerseAudioModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerseAudioModelToJson(this);

  @override
  String toString() {
    return "VerseAudioState(audioEnum=$audioEnum, audioModel=$audio)";
  }

  @override
  List<Object?> get props => [audioEnum,audio,duration,position,isLoop,speed,error,currentIndex,initIndex];
}