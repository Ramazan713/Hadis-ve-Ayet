

import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';

class AudioSettingState extends Equatable{

  final double audioSpeed;
  final bool followAudioText;
  final AudioEdition? audioEdition;

  const AudioSettingState({required this.audioSpeed,
    required this.followAudioText,this.audioEdition});

  AudioSettingState copyWith({double? audioSpeed,
    bool? followAudioText,AudioEdition? audioEdition,bool setEdition=false}){
    return AudioSettingState(
        audioSpeed: audioSpeed??this.audioSpeed,
        followAudioText: followAudioText??this.followAudioText,
        audioEdition: setEdition?audioEdition:this.audioEdition
    );
  }

  static AudioSettingState init(){
    return const AudioSettingState(audioSpeed: 1.0, followAudioText: true);
  }

  @override
  List<Object?> get props => [audioSpeed,followAudioText,audioEdition];

}