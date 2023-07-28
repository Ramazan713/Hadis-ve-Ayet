

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';

class AudioSettingState extends Equatable{

  final double audioSpeed;
  final bool followAudioText;
  final AudioEdition? selectedEdition;

  const AudioSettingState({
    required this.audioSpeed,
    required this.followAudioText,
    this.selectedEdition
  });

  AudioSettingState copyWith({
    double? audioSpeed,
    bool? followAudioText,
    AudioEdition? selectedEdition,bool setSelectedEdition=false
  }){
    return AudioSettingState(
        audioSpeed: audioSpeed ?? this.audioSpeed,
        followAudioText: followAudioText ?? this.followAudioText,
        selectedEdition: setSelectedEdition ? selectedEdition : this.selectedEdition
    );
  }

  static AudioSettingState init(){
    return AudioSettingState(
        audioSpeed: KPref.audioPlayerSpeed.defaultValue,
        followAudioText: KPref.audioFollowWithText.defaultValue
    );
  }

  @override
  List<Object?> get props => [audioSpeed,followAudioText,selectedEdition];

}