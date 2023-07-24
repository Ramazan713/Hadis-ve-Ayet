import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/helper/download_voice_entity.dart';
import 'package:hadith/features/verse/verse_download_audio/models/download_voice_service_state.dart';

class DownloadAudioStateOld extends Equatable {
  final DownloadVoiceServiceState voiceState;
  final bool downloadFinish;
  final String?message;

  const DownloadAudioStateOld({required this.voiceState, required this.downloadFinish,
    this.message});

  DownloadAudioStateOld copyWith({DownloadVoiceServiceState? voiceState,
    bool? downloadFinish,String?message,bool setMessage=false}){
    return DownloadAudioStateOld(voiceState: voiceState??this.voiceState,
        downloadFinish: downloadFinish??this.downloadFinish,
        message: setMessage?message:this.message
    );
  }

  DownloadVoiceEntity? getVoiceModel(){
    return voiceState.voiceModel;
  }


  static DownloadAudioStateOld init(){
    return DownloadAudioStateOld(voiceState: DownloadVoiceServiceState.init(), downloadFinish: false);
  }

  static DownloadAudioStateOld? fromServiceState(DownloadVoiceServiceState? state){
    return state==null ? null : DownloadAudioStateOld(voiceState: state, downloadFinish: false);
  }

  @override
  List<Object?> get props => [voiceState,downloadFinish,message];
}
