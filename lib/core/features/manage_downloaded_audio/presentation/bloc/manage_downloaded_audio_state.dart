
import 'package:equatable/equatable.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/models/downloaded_audio_view_model.dart';

class ManageAudioState extends Equatable{

  final List<DownloadedAudioViewModel> models;
  final bool isLoading;
  final DownloadedAudioViewEnum? selectedEnum;
  final String? selectedIdentifier;
  final String? message;

  const ManageAudioState({
    required this.models,
    required this.isLoading,
    this.selectedEnum,
    this.selectedIdentifier,
    this.message
  });

  ManageAudioState copyWith({
    List<DownloadedAudioViewModel>? models,
    bool? isLoading,
    DownloadedAudioViewEnum? selectedEnum, bool setSelectedEnum = false,
    String? selectedIdentifier, bool setSelectedIdentifier = false,
    String? message, bool setMessage = false
  }){
    return ManageAudioState(
        models: models ?? this.models,
        isLoading: isLoading ?? this.isLoading,
        selectedEnum: setSelectedEnum ? selectedEnum : this.selectedEnum,
        message: setMessage ? message : this.message,
        selectedIdentifier: setSelectedIdentifier ? selectedIdentifier : this.selectedIdentifier
    );
  }

  static ManageAudioState init(){
    return const ManageAudioState(
      isLoading: false,
      models: []
    );
  }

  @override
  List<Object?> get props => [models, isLoading, selectedEnum, selectedIdentifier, message];

}