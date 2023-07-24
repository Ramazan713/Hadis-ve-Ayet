

import 'dart:async';
import 'dart:convert';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/model/service_audio/background_service_enum_wrapper.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/features/verses/shared/domain/model/service_audio/background_event.dart';
import 'package:hadith/features/verses/shared/domain/model/service_audio/foreground_send_data.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:rxdart/rxdart.dart';

import '../model/download_verse/audio_download_event.dart';
import '../model/listen_audio/audio_listen_event.dart';

abstract class BackgroundVerseAudioManager{

  Future<void> init();

  Future<void> cancel();

  Future<void> dispose();



  static Future<void> onEvent(BackgroundEvent event)async{
    final service = FlutterBackgroundService();
    final key = event.eventKey;

    if(!await service.isRunning()){
      await service.startService();
      await Future.delayed(const Duration(milliseconds: K.delayForStartingServiceInMilliSeconds));
    }
    switch(event){
      case BackgroundEventStartListenAudio _:
        service.invoke(key,{"data": event.audioParam.toJson()});
        break;
      case BackgroundEventStartDownloadAudio _:
        service.invoke(key,{"data": event.audioDownloadParam.toJson()});
        break;
      case BackgroundEventStopListenAudio _:
        service.invoke(key);
        break;
      case BackgroundEventStopDownloadAudio _:
        service.invoke(key);
        break;
      case BackgroundEventStopAll _:
        service.invoke(key);
        break;
      case BackgroundEventCheckNotificationStatus _:
        service.invoke(key);
        break;
    }
  }


  static Stream<ListenAudioServiceState?> getListenAudioData(){
    final service = FlutterBackgroundService();
    return service.on(BackgroundSendData.sendListenAudioData).asBroadcastStream().map((event){
      return ListenAudioServiceState.fromJson(event?["data"]).castOrNull<ListenAudioServiceState>();
    });
  }

  static ValueStream<int?> getListenAudioSelectedSavePointId(){
    final service = FlutterBackgroundService();
    return service.on(BackgroundSendData.sendListenAudioSelectedSavePointId).map<int?>((event){
      return event?["data"];
    }).shareValue();
  }

  static Stream<DownloadAudioManagerState?> getDownloadAudioData(){
    final service = FlutterBackgroundService();
    return service.on(BackgroundSendData.sendDownloadAudioData).asBroadcastStream().map((event){
      return DownloadAudioManagerState.fromJson(event?["data"]).castOrNull<DownloadAudioManagerState>();
    });
  }

  static Stream<Set<AudioServiceEnum>> getActiveServices(){
    final service = FlutterBackgroundService();
    return service.on(BackgroundSendData.sendActiveServices).asBroadcastStream().map((event){
      try{
        final wrapperList = (jsonDecode(event?["data"]) as List).map((e) => BackgroundServiceEnumWrapper.fromJson(e)).toList();
        return wrapperList.map((e) => e.serviceEnum).toSet();
      }catch(e){
        return {};
      }
    });
  }

  static Future<void> onDownloadAudioEvent(AudioDownloadEvent event) async{
    final service = FlutterBackgroundService();
    final key = event.eventKey;

    switch(event){
      case AudioDownloadEventResume _:
        service.invoke(key);
        break;
      case AudioDownloadEventPause _:
        service.invoke(key);
        break;
      case AudioDownloadEventRetry _:
        service.invoke(key);
        break;
      case AudioDownloadEventCancel _:
        service.invoke(key);
        break;
    }

  }

  static Future<void> onListenAudioEvent(AudioListenEvent event) async{
    final service = FlutterBackgroundService();
    final key = event.eventKey;

    switch(event){
      case AudioListenEventResume _:
        service.invoke(key);
        break;
      case AudioListenEventPause _:
        service.invoke(key);
        break;
      case AudioListenEventSetPosition _:
        service.invoke(key,{"data": event.duration.inMilliseconds});
        break;
        case AudioListenEventSetSpeed _:
          service.invoke(key,{"data": event.speed});
        break;
      case AudioListenEventSetLoop _:
        service.invoke(key,{"data": event.loop});
        break;
      case AudioListenEventSetSavePoint _:
        service.invoke(key,{"data": event.savePointId});
        break;
    }

  }
}

