

import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/domain/repo/verse/verse_repo.dart';
import 'package:hadith/core/domain/use_cases/save_point/insert_or_update_auto_save_point.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/enums/listen_audio_enum.dart';
import 'package:hadith/features/verses/shared/domain/manager/quran_listen_audio_foreground_manager.dart';
import 'package:hadith/features/verses/shared/domain/model/service_audio/foreground_send_data.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/audio_listen_event.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:hadith/features/verses/shared/domain/notification/i_verse_listen_audio_notification.dart';
import 'package:hadith/features/verses/shared/domain/services/i_verse_audio_service.dart';
import 'package:mutex/mutex.dart';


class QuranListenAudioBackgroundManagerImpl extends QuranListenAudioBackgroundManager{

  late final ServiceInstance _service;
  late final InsertOrUpdateAutoSavePoint _insertOrUpdateAutoSavePoint;
  late final IVerseAudioServiceManager _audioService;
  late final IVerseListenAudioNotification _notification;
  late final VerseRepo _verseRepo;
  late final void Function() _onCancel;
  late final void Function(String) _handleNotificationBase;
  int? _selectedSavePointId;
  ListenAudioParam? _audioParam;

  final _m = Mutex();

  StreamSubscription<ListenAudioServiceState>? _subsReceiveAudioState;
  StreamSubscription<ListenAudioServiceState>? _subsReceiveAudioStateForNotification;
  StreamSubscription<dynamic>? _subsPort;

  StreamSubscription<dynamic>? _subsPauseEvent;
  StreamSubscription<dynamic>? _subsResumeEvent;
  StreamSubscription<dynamic>? _subsSetLoopEvent;
  StreamSubscription<dynamic>? _subsSetDurationEvent;
  StreamSubscription<dynamic>? _subsSetSpeedEvent;
  StreamSubscription<dynamic>? _subsSetSavePointIdEvent;
  StreamSubscription<dynamic>? _subsListeningStop;

  StreamSubscription<SavePoint?>? _subsSelectedSavePoint;


  QuranListenAudioBackgroundManagerImpl({
    required ServiceInstance service,
    required InsertOrUpdateAutoSavePoint insertOrUpdateAutoSavePoint,
    required IVerseAudioServiceManager audioService,
    required VerseRepo verseRepo,
    required IVerseListenAudioNotification notification,
    required void Function() onCancel,
    required void Function(String) handleNotificationBase
  }){
    _service = service;
    _insertOrUpdateAutoSavePoint = insertOrUpdateAutoSavePoint;
    _audioService = audioService;
    _verseRepo = verseRepo;
    _notification = notification;
    _onCancel = onCancel;
    _handleNotificationBase = handleNotificationBase;

    _notificationListener();
  }


  @override
  void runService(ListenAudioParam audioParam)async{

    await _initListeners();

    _audioParam = audioParam;
    await _audioService.playAudios(audioParam);
  }

  Future<void> _initListeners()async{
    await _notification.showInitNotification();

    await cancel();
    _serviceEventsListener();
    _audioServiceListener();
  }

  @override
  Future<void> cancel() async{
    _notifySelectedSavePointId(null);
    await _audioService.stop();
    await _notification.dismiss();
    await _cancelServiceEventsListeners();
    await _cancelAudioServiceListeners();
  }

  @override
  Future<void> dispose()async{
    await cancel();
    await _cancelNotificationListener();
    await _subsSelectedSavePoint?.cancel();
    await _audioService.dispose();
  }

  @override
  Future<void> setFinishPlayer() async{
    await _audioService.setFinish();
  }

}

extension SetListenersExt on QuranListenAudioBackgroundManagerImpl{

  void _audioServiceListener(){

    _subsReceiveAudioState = _audioService.broadcastListener.listen((event)async{
      _service.invoke(BackgroundSendData.sendListenAudioData,{"data": event.toJson()});
      if(event.error!=null || event.audioEnum == ListenAudioEnum.finish){
        await _saveSavePoints(event.audio);
        _onCancel.call();
      }
    });

    _subsReceiveAudioStateForNotification = _audioService.broadcastListener.distinct((prev,next)=>next.isDistinctForNotification(prev))
        .listen((event) {
      _notification.showNotification(event);
    });
  }

  void _serviceEventsListener(){
    _subsPauseEvent = _service.on(AudioListenEventPause.key).listen((event){
      _audioService.pause();
    });

    _subsResumeEvent = _service.on(AudioListenEventResume.key).listen((event){
      _audioService.resume();
    });

    _subsSetSpeedEvent = _service.on(AudioListenEventSetSpeed.key).listen((event){
      final double speed = event?["data"];
      _audioService.changeSpeed(speed);
    });

    _subsSetDurationEvent = _service.on(AudioListenEventSetPosition.key).listen((event){
      final int milliseconds = event?["data"];
      _audioService.changePosition(Duration(milliseconds: milliseconds));
    });

    _subsSetLoopEvent = _service.on(AudioListenEventSetLoop.key).listen((event){
      final bool isLoop = event?["data"];
      _audioService.setLoop(isLoop);
    });

    _subsSetSavePointIdEvent = _service.on(AudioListenEventSetSavePoint.key).listen((event) {
      _notifySelectedSavePointId(event?["data"]);
    });
  }

  void _notifySelectedSavePointId(int? selectedSavePointId){
    _selectedSavePointId = selectedSavePointId;
    _service.invoke(BackgroundSendData.sendListenAudioSelectedSavePointId,{"data": selectedSavePointId});
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
        await _audioService.resume();
      }else if(received == keys.pauseKey){
        await _audioService.pause();
      }else if(received == keys.cancelKey){
        await _audioService.setFinish();
      } else{
        _handleNotificationBase(received);
      }
    });
  }
}

extension RemoveListenersExt on QuranListenAudioBackgroundManagerImpl{
  Future<void> _cancelAudioServiceListeners()async{
    await _subsReceiveAudioState?.cancel();
    await _subsReceiveAudioStateForNotification?.cancel();
  }

  Future<void> _cancelServiceEventsListeners()async{
    await _subsSetLoopEvent?.cancel();
    await _subsSetDurationEvent?.cancel();
    await _subsSetSpeedEvent?.cancel();
    await _subsPauseEvent?.cancel();
    await _subsResumeEvent?.cancel();
    await _subsListeningStop?.cancel();
    await _subsSetSavePointIdEvent?.cancel();
  }

  Future<void> _cancelNotificationListener()async{
    await _subsPort?.cancel();
    IsolateNameServer.removePortNameMapping(_notification.isolateName);
  }
}

extension SavePointExt on QuranListenAudioBackgroundManagerImpl{

  Future<_SavePointResult?> _getSavePointDestination(
      VerseMealVoiceModel verseModel,
      ListenAudioParam audioParam,{
        bool getExactDestination = false
      }
  )async{
    SavePointDestination? destination;
    int? pos;

    switch(audioParam.op){
      case QuranAudioOption.cuz:
        destination = DestinationCuz(cuzName: verseModel.cuzName, cuzId: verseModel.cuzNo);
        pos = await _verseRepo.getCuzPosById(verseModel.mealId, verseModel.cuzNo);
        break;
      case QuranAudioOption.surah:
        destination = DestinationSurah(surahId: verseModel.surahId, surahName: verseModel.surahName);
        pos = await _verseRepo.getSurahPosById(verseModel.mealId, verseModel.surahId);
        break;
      default:
        if(getExactDestination){
          destination = DestinationSurah(surahId: verseModel.surahId, surahName: verseModel.surahName);
          pos = await _verseRepo.getSurahPosById(verseModel.mealId, verseModel.surahId);
        }
        break;
    }
    if(destination!=null && pos != null){
      return _SavePointResult(destination: destination, pos: pos);
    }
    return null;
  }

  Future<void> _saveSelectedSavePoint(VerseMealVoiceModel verseModel, ListenAudioParam audioParam)async{
    final savePointId = _selectedSavePointId;
    if(savePointId == null) return;

    final destinationResult = await _getSavePointDestination(verseModel, audioParam,getExactDestination: true);
    if(destinationResult == null) return;

    await _insertOrUpdateAutoSavePoint.callWithId(
      savePointId: savePointId,
      destination: destinationResult.destination,
      itemIndexPos: destinationResult.pos,
    );
  }

  Future<void> _saveAutoSavePoint(VerseMealVoiceModel verseModel, ListenAudioParam audioParam)async{
    final destinationResult = await _getSavePointDestination(verseModel, audioParam, getExactDestination: false);
    if(destinationResult == null) return;

    await _insertOrUpdateAutoSavePoint.call(
        destination: destinationResult.destination,
        itemIndexPos: destinationResult.pos,
        autoType: SaveAutoType.audio
    );
  }


  Future<void> _saveSavePoints(VerseMealVoiceModel? verseModel)async{
    final audioParam = _audioParam;

    if(verseModel == null || audioParam == null) return;

    await _m.acquire();
    try{
      await _saveSelectedSavePoint(verseModel, audioParam);
      await _saveAutoSavePoint(verseModel, audioParam);
    }finally{
      _m.release();
    }
  }

}


class _SavePointResult extends Equatable{
  final SavePointDestination destination;
  final int pos;

  const _SavePointResult({required this.destination, required this.pos});

  @override
  List<Object?> get props => [pos, destination];
}
