
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';

class SelectEditionState extends Equatable{
  final List<AudioEdition>items;
  final AudioQualityEnum selectedQuality;
  final AudioEdition? selectedEdition;
  final bool saveButtonEnabled;
  final bool resetButtonEnabled;
  final bool isLoading;
  final String? message;

  const SelectEditionState({
    required this.isLoading,
    this.message,
    required this.selectedQuality,
    this.selectedEdition,
    required this.saveButtonEnabled,
    required this.resetButtonEnabled,
    required this.items
  });

  SelectEditionState copyWith({
    List<AudioEdition>? items,
    bool? isLoading,
    String? message, bool setMessage=false,
    bool? saveButtonEnabled,
    bool? resetButtonEnabled,
    AudioQualityEnum? selectedQuality,
    AudioEdition? selectedEdition, bool setSelectedEdition=false,
  }){
    return SelectEditionState(
        isLoading: isLoading??this.isLoading,
        message: setMessage?message:this.message,
        selectedQuality: selectedQuality??this.selectedQuality,
        selectedEdition: setSelectedEdition?selectedEdition:this.selectedEdition,
        saveButtonEnabled: saveButtonEnabled??this.saveButtonEnabled,
        resetButtonEnabled: resetButtonEnabled??this.resetButtonEnabled,
        items: items??this.items
    );
  }

  static SelectEditionState init(){
    return SelectEditionState(
        isLoading: false,
        items: const[],
        selectedQuality: KPref.audioQualityEnum.defaultPrefEnum,
        resetButtonEnabled: false,
        saveButtonEnabled: false
    );
  }

  @override
  String toString() {
    return "EditionState(isLoading=$isLoading, error=$message)";
  }

  @override
  List<Object?> get props => [
    isLoading,message,selectedQuality,
    selectedEdition,saveButtonEnabled,resetButtonEnabled,items
  ];
}
