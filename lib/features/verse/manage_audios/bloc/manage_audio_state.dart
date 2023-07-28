

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/manage_audios/audio_manage_enum.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_model.dart';

class ManageAudioStateOld extends Equatable{

  final List<ManageAudioModel>manageModels;
  final bool isLoading;
  final AudioManageEnum manageEnum;

  const ManageAudioStateOld({required this.manageModels, required this.isLoading,required this.manageEnum});

  ManageAudioStateOld copyWith({List<ManageAudioModel>?manageModels,bool?isLoading,AudioManageEnum?manageEnum}){
    return ManageAudioStateOld(
        isLoading: isLoading??this.isLoading,
        manageModels: manageModels??this.manageModels,
        manageEnum: manageEnum??this.manageEnum
    );
  }

  static ManageAudioStateOld init(){
    return const ManageAudioStateOld(isLoading: false,manageModels: [],manageEnum:AudioManageEnum.surah);
  }

  @override
  List<Object?> get props => [manageModels,manageEnum,isLoading];

}