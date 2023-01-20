import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/helper/download_voice_entity.dart';
import 'package:hadith/features/verse/verse_download_audio/models/download_voice_service_state.dart';

class DownloadAudioState extends Equatable {
  final DownloadVoiceServiceState voiceState;
  final bool downloadFinish;
  final String?message;

  const DownloadAudioState({required this.voiceState, required this.downloadFinish,
    this.message});

  DownloadAudioState copyWith({DownloadVoiceServiceState? voiceState,
    bool? downloadFinish,String?message,bool setMessage=false}){
    return DownloadAudioState(voiceState: voiceState??this.voiceState,
        downloadFinish: downloadFinish??this.downloadFinish,
        message: setMessage?message:this.message
    );
  }

  DownloadVoiceEntity? getVoiceModel(){
    return voiceState.voiceModel;
  }


  static DownloadAudioState init(){
    return DownloadAudioState(voiceState: DownloadVoiceServiceState.init(), downloadFinish: false);
  }

  static DownloadAudioState? fromServiceState(DownloadVoiceServiceState? state){
    return state==null ? null : DownloadAudioState(voiceState: state, downloadFinish: false);
  }

  @override
  List<Object?> get props => [voiceState,downloadFinish,message];
}
