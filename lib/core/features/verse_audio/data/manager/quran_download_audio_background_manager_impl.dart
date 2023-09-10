
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/download_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/quran_download_audio_background_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/verse_audio_download_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/audio_download_event.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/service_audio/foreground_send_data.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/i_verse_download_audio_notification.dart';

class QuranDownloadAudioBackgroundManagerImpl extends QuranDownloadAudioBackgroundManager{

  late final ServiceInstance _service;
  late final IVerseDownloadAudioNotification _notification;
  late final VerseAudioDownloadManager _audioDownloadManager;
  late final void Function() _onCancel;
  late final void Function(String) _handleNotificationBase;

  StreamSubscription<DownloadAudioManagerState>? _subsReceiveAudioStateForNotification;
  StreamSubscription<dynamic>? _subsPort;

  StreamSubscription<dynamic>? _subsPauseEvent;
  StreamSubscription<dynamic>? _subsResumeEvent;
  StreamSubscription<dynamic>? _subsCancelEvent;
  StreamSubscription<dynamic>? _subsRetryEvent;

  QuranDownloadAudioBackgroundManagerImpl({
    required ServiceInstance service,
    required IVerseDownloadAudioNotification notification,
    required VerseAudioDownloadManager audioDownloadManager,
    required void Function() onCancel,
    required void Function(String) handleNotificationBase
  }){
    _service = service;
    _audioDownloadManager = audioDownloadManager;
    _notification = notification;
    _onCancel = onCancel;
    _handleNotificationBase = handleNotificationBase;

    _notificationListener();
  }

  @override
  void addDownloadQueue(DownloadAudioParam param)async{
    if(_audioDownloadManager.state.downloadEnum.isAvailable){
      await _initListeners();
    }
    _audioDownloadManager.addQueue(param);
  }

  Future<void> _initListeners()async{
    await _cancelListeners();
    _audioDownloadServiceListener();
    _serviceEventsListener();
  }

  @override
  Future<void> cancel() async{
    await _notification.dismiss();
    await _cancelListeners();
    await _audioDownloadManager.cancel();
  }

  @override
  Future<void> dispose()async{
    await cancel();
    await _cancelNotificationListener();
    _audioDownloadManager.dispose();
  }
}

extension SetListenersExt on QuranDownloadAudioBackgroundManagerImpl{

  void _audioDownloadServiceListener(){

    _subsReceiveAudioStateForNotification = _audioDownloadManager.broadcastListener?.listen((event) async{
      _service.invoke(BackgroundSendData.sendDownloadAudioData,{"data":event.toJson()});
      await _notification.showNotification(event);

      if(event.downloadEnum == DownloadEnum.successAll){
        _onCancel();
      }
    });
  }

  void _serviceEventsListener(){
    _subsPauseEvent = _service.on(AudioDownloadEventPause.key).listen((event){
      _audioDownloadManager.pause();
    });

    _subsResumeEvent = _service.on(AudioDownloadEventResume.key).listen((event){
      _audioDownloadManager.resume();
    });

    _subsCancelEvent = _service.on(AudioDownloadEventCancel.key).listen((event)async{
      await _audioDownloadManager.cancel();
      _onCancel();
    });

    _subsRetryEvent = _service.on(AudioDownloadEventRetry.key).listen((event){
      _audioDownloadManager.retry();
    });
  }



  void _notificationListener(){
    ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _notification.isolateName,
    );

    final keys = _notification.notificationKeys;

    _subsPort = port.listen((received) async {
      if( received == keys.continueKey){
        _audioDownloadManager.resume();
      }else if(received == keys.pauseKey){
        _audioDownloadManager.pause();
      }else if(received == keys.cancelKey){
        await _audioDownloadManager.cancel();
        _onCancel();
      }else if(received == keys.retryKey){
        _audioDownloadManager.retry();
      }else{
        _handleNotificationBase(received);
      }
    });
  }
}


extension RemoveListenersExt on QuranDownloadAudioBackgroundManagerImpl{

  Future<void> _cancelListeners()async{
    await _cancelAudioServiceListeners();
    await _cancelServiceEventsListeners();
  }

  Future<void> _cancelAudioServiceListeners()async{
    await _subsReceiveAudioStateForNotification?.cancel();
  }

  Future<void> _cancelServiceEventsListeners()async{

    await _subsPauseEvent?.cancel();
    await _subsResumeEvent?.cancel();
    await _subsCancelEvent?.cancel();
    await _subsRetryEvent?.cancel();
  }

  Future<void> _cancelNotificationListener()async{
    await _subsPort?.cancel();
    IsolateNameServer.removePortNameMapping(_notification.isolateName);
  }
}
