

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/manage_audios/audio_manage_enum.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_model.dart';

abstract class IManageAudioEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class ManageAudioEventInit extends IManageAudioEvent{}

class ManageAudioEventChangeType extends IManageAudioEvent{
  final AudioManageEnum manageEnum;
  ManageAudioEventChangeType(this.manageEnum);
  @override
  List<Object?> get props => [manageEnum];
}

class ManageAudioEventDelete extends IManageAudioEvent{
  final ManageAudioModel manageModel;

  ManageAudioEventDelete(this.manageModel);
  @override
  List<Object?> get props => [manageModel];
}

class ManageAudioEventSetIdentifier extends IManageAudioEvent{
  final String identifier;

  ManageAudioEventSetIdentifier(this.identifier);
  @override
  List<Object?> get props => [identifier];
}




