
import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';

class EditionState extends Equatable{
  final List<AudioEdition>filteredItems;
  final List<AudioEdition>items;
  final AudioQualityEnum initAudioQuality;
  final AudioQualityEnum lastAudioQuality;
  final AudioEdition? initSelectedEdition;
  final AudioEdition? lastSelectedEdition;
  final bool saveButtonEnabled;
  final bool resetButtonEnabled;
  final bool isLoading;
  final String? message;

  const EditionState({required this.filteredItems,required this.isLoading,this.message,
    required this.initAudioQuality,required this.lastAudioQuality,this.initSelectedEdition,
    this.lastSelectedEdition, required this.saveButtonEnabled, required this.resetButtonEnabled,
    required this.items
  });

  EditionState copyWith({List<AudioEdition>? filteredItems,List<AudioEdition>? items,
    bool? isLoading,
    String? message, bool setMessage=false,bool? saveButtonEnabled,bool? resetButtonEnabled,
    AudioQualityEnum? initAudioQuality,AudioQualityEnum? lastAudioQuality,
    AudioEdition? initSelectedEdition, bool setInitEdition=false,
    AudioEdition? lastSelectedEdition, bool setLastEdition=false
  }){
    return EditionState(filteredItems: filteredItems??this.filteredItems, isLoading: isLoading??this.isLoading,
        message: setMessage?message:this.message,
        initAudioQuality: initAudioQuality??this.initAudioQuality,
        lastAudioQuality: lastAudioQuality??this.lastAudioQuality,
        initSelectedEdition: setInitEdition?initSelectedEdition:this.initSelectedEdition,
        lastSelectedEdition: setLastEdition?lastSelectedEdition:this.lastSelectedEdition,
        saveButtonEnabled: saveButtonEnabled??this.saveButtonEnabled,
        resetButtonEnabled: resetButtonEnabled??this.resetButtonEnabled,
        items: items??this.items
    );
  }

  static EditionState init(){
    return const EditionState(
      filteredItems: [], isLoading: false,items:[],
      initAudioQuality: AudioQualityEnum.q64,lastAudioQuality: AudioQualityEnum.q64,
      resetButtonEnabled: false,saveButtonEnabled: false
    );
  }

  @override
  String toString() {
    return "EditionState(isLoading=$isLoading, error=$message, len=${filteredItems.length}, items=$filteredItems)";
  }

  @override
  List<Object?> get props => [filteredItems,isLoading,message,initAudioQuality,lastAudioQuality,
    initSelectedEdition,lastSelectedEdition,saveButtonEnabled,resetButtonEnabled,items
  ];
}
