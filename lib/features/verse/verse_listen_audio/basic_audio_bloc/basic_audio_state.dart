

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/verse_audio_model.dart';

class BasicAudioState extends Equatable{
  final VerseAudioModel?audioModel;
  final String?message;
  final bool isDownloading;
  final String?currentIdentifier;
  final bool isDisabled;

  const BasicAudioState({this.audioModel, this.message,required this.isDownloading,
    this.currentIdentifier,required this.isDisabled});

  BasicAudioState copyWith({VerseAudioModel?audioModel,bool setAudio=false,String?message,bool setMessage=false,
    bool? isDownloading,String?currentIdentifier,bool setIdentifier=false,bool?isDisabled
  }){
    return BasicAudioState(
        audioModel: setAudio?audioModel:this.audioModel,
        message: setMessage?message:this.message,
        isDownloading: isDownloading??this.isDownloading,
        currentIdentifier: setIdentifier?currentIdentifier:this.currentIdentifier,
        isDisabled: isDisabled??this.isDisabled
    );
  }

  static BasicAudioState init(){
    return const BasicAudioState(isDownloading:false,isDisabled:false);
  }

  AudioEnum? getAudioEnum(){
    return audioModel?.audioEnum;
  }

  @override
  List<Object?> get props => [audioModel,message,isDownloading,currentIdentifier,isDisabled];
}