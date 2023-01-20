
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_state.dart';
import 'package:hadith/features/verse/verse_download_audio/constants/download_enum.dart';
import 'package:hadith/features/verse/verse_download_audio/models/download_voice_service_state.dart';
import 'package:hadith/features/verse/verse_download_audio/services/quran_download_foreground_service.dart';
import 'package:hadith/services/connectivity_service.dart';
import 'package:hadith/services/foreground_service/foreground_service_helper.dart';
import 'package:rxdart/rxdart.dart';

class DownloadAudioBloc extends Bloc<IDownloadAudioEvent,DownloadAudioState>{

  DownloadAudioBloc() : super(DownloadAudioState.init()){
    on<DownloadAudioEventStart>(_onStartDownloading,transformer: restartable());
    on<DownloadAudioEventListen>(_onBootListening);
    on<DownloadAudioEventResume>(_onResume,transformer: restartable());
    on<DownloadAudioEventPause>(_onPause,transformer: restartable());
    on<DownloadAudioEventCancel>(_onCancel,transformer: restartable());
    on<DownloadAudioEventRetry>(_onRetry,transformer: restartable());

    add(DownloadAudioEventListen());
  }
  void _onBootListening(DownloadAudioEventListen event,Emitter<DownloadAudioState>emit)async{
    final streamData = QuranDownloadForegroundService.getStateStream();
    await emit.forEach<DownloadAudioState>(streamData.mapNotNull((e)=>DownloadAudioState.fromServiceState(e)), onData: (data){
      if(data.voiceState.downloadEnum==DownloadEnum.success){
        return data.copyWith(downloadFinish: true);
      }
      return data;
    });
  }

  void _sendMessage(String message,Emitter<DownloadAudioState>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true));
  }

  void _onStartDownloading(DownloadAudioEventStart event,Emitter<DownloadAudioState>emit)async{
    if(!await ConnectivityService.isConnectedInternet()){
      return _sendMessage("internet bağlantınızı kontrol edin", emit);
    }
    ForegroundServiceHelper.startService();
    await Future.delayed(const Duration(seconds: kDelayForStartingServiceInSeconds));
    QuranDownloadForegroundService.startDownloadingVoices(AudioParam.fromVerse(event.verse, event.option));
  }

  void _onResume(DownloadAudioEventResume event,Emitter<DownloadAudioState>emit)async{
    QuranDownloadForegroundService.resume();
  }

  void _onPause(DownloadAudioEventPause event,Emitter<DownloadAudioState>emit)async{
    QuranDownloadForegroundService.pause();
  }

  void _onCancel(DownloadAudioEventCancel event,Emitter<DownloadAudioState>emit)async{
    QuranDownloadForegroundService.cancel();
  }

  void _onRetry(DownloadAudioEventRetry event,Emitter<DownloadAudioState>emit)async{
    QuranDownloadForegroundService.retry();
  }


}