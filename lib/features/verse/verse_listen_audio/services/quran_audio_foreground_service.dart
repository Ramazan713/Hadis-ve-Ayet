

import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';
import 'package:hadith/db/instance.dart';
import 'package:hadith/db/repos/cuz_repo.dart';
import 'package:hadith/db/repos/save_point_repo.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/db/repos/verse_audio_state_repo.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/save_point/save_point_param.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/audio_attribute_state.dart';
import 'package:hadith/features/verse/verse_listen_audio/services/i_verse_audio_service.dart';
import 'package:hadith/features/verse/verse_listen_audio/notification_audio_verse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/verse_audio_model.dart';
import 'package:mutex/mutex.dart';

const String _listenState = "_listenState";
const String _startListening = "_startListening";
const String _sendAttributeState = "_listenSendAttributeState";

const String _onListeningPause = "_onListeningPause";
const String _onListeningStop = "_onListeningStop";
const String _onListeningResume = "_onListeningResume";
const String _onListeningSetSpeed = "_onListeningSetSpeed";
const String _onListeningSetPosition = "_onListeningSetDuration";
const String _onListeningSetLoop = "_onListeningSetLoop";
const String _onListeningSetSavePointId = "_onListeningSetSavePointId";


class QuranAudioForegroundService{
  final NotificationAudioVerse _notification = NotificationAudioVerse();

  IVerseAudioService? _audioService;

  StreamSubscription<VerseAudioModel>? _subsState;
  StreamSubscription<VerseAudioModel>? _subsStateNotification;
  StreamSubscription<Map<String, dynamic>?>? _subsListeningEvents;
  StreamSubscription<dynamic>? _subsPort;

  StreamSubscription<dynamic>? _subsListeningPauseEvents;
  StreamSubscription<dynamic>? _subsListeningResumeEvents;
  StreamSubscription<dynamic>? _subsListeningSetLoopEvents;
  StreamSubscription<dynamic>? _subsListeningSetDurationEvents;
  StreamSubscription<dynamic>? _subsListeningSetSpeedEvents;
  StreamSubscription<dynamic>? _subsListeningSetSavePointIdEvents;
  StreamSubscription<dynamic>? _subsListeningStop;


  late final Future Function()_onCancel;
  late final ServiceInstance _service;
  final _m = Mutex();

  SavePointRepo? _savePointRepo;
  VerseAudioStateRepo? _verseAudioStateRepo;
  CuzRepo? _cuzRepo;
  AudioParam? _audioParam;

  AudioAttributeState _attributeState = AudioAttributeState.init();

  QuranAudioForegroundService({required ServiceInstance service,required Future Function()onCancel}){
    _onCancel = onCancel;
    _service = service;

    _subsListeningEvents = _service.on(_startListening).listen((event) {
      final AudioParam audioParam = AudioParam.fromJson(event?["audioParam"]);
      final String? identifier = event?["identifier"];

      if(identifier!=null){
        _addState(AudioAttributeState.init());
        runService(audioParam,identifier);
      }
    });

  }

  Future<void> runService(AudioParam audioParam,String identifier)async{
    _audioParam = audioParam;
    await _audioService?.dispose();
    await _notification.initListeners(_notificationTapBackground);

    final database = await _getDatabase();
    final verseAudioRepo = VerseAudioRepo(verseAudioDao: database.verseAudioDao);
    _verseAudioStateRepo = VerseAudioStateRepo(audioStateDao: database.verseAudioStateDao);
    _savePointRepo = SavePointRepo(savePointDao: database.savePointDao);
    _cuzRepo = CuzRepo(cuzDao: database.cuzDao);

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    _audioService = VerseAudioJustService(
        sharedPreferences: sharedPreferences,
        verseAudioRepo: verseAudioRepo,verseAudioStateRepo: _verseAudioStateRepo!);

    _listenServiceEvents();
    _audioService?.playAudios(audioParam,identifier);

    _listenNotificationButtons();
    await _notification.showNotification(VerseAudioModel.init());
  }


  Future<SavePointParam?> _getSavePointParam(VerseAudioModel verseAudioModel,{bool getResultForAllOption=false})async{
    final audioEntity=verseAudioModel.audio;
    final option = _audioParam?.option;
    if(audioEntity == null || option == null) return null;
    final index = verseAudioModel.currentIndex + verseAudioModel.initIndex + 1;
    switch(option){
      case QuranAudioOption.surah:
        return SavePointParam(parentName: audioEntity.surahName,parentKey: audioEntity.surahId.toString(),
            itemIndexPos: index,bookScope: BookScopeEnum.diyanetMeal,originTag: OriginTag.surah);
      case QuranAudioOption.cuz:
        final cuz = await _cuzRepo?.getCuz(audioEntity.cuzNo);
        if(cuz!=null){
          return SavePointParam(parentName: cuz.name,parentKey: cuz.cuzNo.toString(),
              itemIndexPos: index,bookScope: BookScopeEnum.diyanetMeal,originTag: OriginTag.cuz);
        }
        break;
      default:
        if(getResultForAllOption){
          final pos = await _verseAudioStateRepo?.getSurahVersePosition(audioEntity.surahId, audioEntity.mealId);
          return SavePointParam(parentName: audioEntity.surahName,parentKey: audioEntity.surahId.toString(),
              itemIndexPos: pos??0,bookScope: BookScopeEnum.diyanetMeal,originTag: OriginTag.surah);
        }
        return null;
    }
    return null;
  }

  Future<void>_makeAutoSavePoint(VerseAudioModel verseAudioModel)async{
    await _m.acquire();
    try{
      if(_audioParam!=null&&_savePointRepo!=null){
        final savePointParam = await _getSavePointParam(verseAudioModel);
        if(savePointParam!=null){
          await _savePointRepo?.saveOrReplaceAutoSavePoint(savePointParam, SaveAutoType.audio);
        }
      }
    }finally{
      _m.release();
    }
  }

  Future<void> _updateSavepoint(VerseAudioModel verseAudioModel)async{
    final savepointId = _attributeState.savepointId;
    if(savepointId==null)return;
    final savepointParam = await _getSavePointParam(verseAudioModel,getResultForAllOption: true);
    if(savepointParam==null)return;
    final savePoint = await _savePointRepo?.getSavePointWithId(savepointId);
    if(savePoint==null)return;
    final updatedSavepoint = savepointParam.toSavePointFromSavePoint(savePoint);
    await _savePointRepo?.updateSavePoint(updatedSavepoint);
  }


  void _endService(VerseAudioModel event)async{
    await _makeAutoSavePoint(event);
    await _updateSavepoint(event);
    await _callOnCancel();
  }

  void _listenServiceEvents()async{
    await _cancelListeners();
    _subsState = _audioService?.broadcastListener?.listen((event){
      _service.invoke(_listenState,{"state":event.toJson()});
      if(event.error!=null){
        _endService(event);
      }
      if(event.audioEnum == AudioEnum.finish){
        _endService(event);
      }
    });

    _subsStateNotification = _audioService?.broadcastListener?.distinct((prev,next)=>next.isDistinctForNotification(prev))
        .listen((event) {
       _notification.showNotification(event);
    });

    _subsListeningPauseEvents = _service.on(_onListeningPause).listen((event){
      _audioService?.pause();
    });

    _subsListeningResumeEvents = _service.on(_onListeningResume).listen((event){
      _audioService?.resume();
    });

    _subsListeningSetSpeedEvents = _service.on(_onListeningSetSpeed).listen((event){
      final double speed = event?["data"];
      _audioService?.changeSpeed(speed);
    });

    _subsListeningSetDurationEvents = _service.on(_onListeningSetPosition).listen((event){
      final int milliseconds = event?["data"];
      _audioService?.changePosition(Duration(milliseconds: milliseconds));
    });

    _subsListeningSetLoopEvents = _service.on(_onListeningSetLoop).listen((event){
      final bool isLoop = event?["data"];
      _audioService?.setLoop(isLoop);
    });

    _subsListeningStop = _service.on(_onListeningStop).listen((event){
      _audioService?.setFinish();
    });

    _subsListeningSetSavePointIdEvents = _service.on(_onListeningSetSavePointId).listen((event) {
      final int? savepointId = event?["data"];
      _addState(_attributeState.copyWith(savepointId: savepointId,setSavepointId: true));
    });

  }

  void _addState(AudioAttributeState newState){
    _attributeState = newState;
    _service.invoke(_sendAttributeState,{"state": newState.toJson()});
  }

  void _listenNotificationButtons(){

    ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      NotificationAudioVerse.notificationActionIsolateName,
    );

    _subsPort=port.listen((received) async {
      switch(received){
        case NotificationAudioVerse.continueButton:
          await _audioService?.resume();
          break;
        case NotificationAudioVerse.pauseButton:
          await _audioService?.pause();
          break;
        case NotificationAudioVerse.cancelButton:
          await _audioService?.setFinish();
          break;
      }
    });
  }

  Future<void>_callOnCancel()async{
    await dispose();
    await _onCancel.call();
  }

  Future<void> _cancelListeners()async{
    await _subsListeningSetLoopEvents?.cancel();
    await _subsListeningSetDurationEvents?.cancel();
    await _subsListeningSetSpeedEvents?.cancel();
    await _subsListeningPauseEvents?.cancel();
    await _subsListeningResumeEvents?.cancel();
    await _subsState?.cancel();
    await _subsStateNotification?.cancel();
    await _subsListeningStop?.cancel();
    await _subsListeningSetSavePointIdEvents?.cancel();
  }

  Future<void> dispose()async{
    await _audioService?.dispose();
    IsolateNameServer.removePortNameMapping(NotificationAudioVerse.notificationActionIsolateName);
    await _cancelListeners();
    await _subsPort?.cancel();
    await _subsListeningEvents?.cancel();

  }

  Future<AppDatabase>_getDatabase(){
    return getDatabase();
  }


  static void resume(){
    FlutterBackgroundService().invoke(_onListeningResume);
  }
  static void pause(){
    FlutterBackgroundService().invoke(_onListeningPause);
  }

  static void setPosition(Duration position){
    FlutterBackgroundService().invoke(_onListeningSetPosition,{"data": position.inMilliseconds});
  }

  static void setSpeed(double speed){
    FlutterBackgroundService().invoke(_onListeningSetSpeed,{"data":speed});
  }

  static void setLoop(bool isLoop){
    FlutterBackgroundService().invoke(_onListeningSetLoop,{"data":isLoop});
  }

  static void setSavePointId(int? savepointId){
    FlutterBackgroundService().invoke(_onListeningSetSavePointId,{"data": savepointId});
  }

  static void stopService()async{
    final service = FlutterBackgroundService();
    if(await service.isRunning()){
      service.invoke(_onListeningStop);
    }
  }


  static void startListeningVoices(AudioParam audioParam,String identifier){
    final service = FlutterBackgroundService();
    service.invoke(_startListening,{"audioParam":audioParam.toJson(),"identifier":identifier});
  }

  static Stream<VerseAudioModel?> getStateStream(){
    final service = FlutterBackgroundService();
    return service.on(_listenState).asBroadcastStream().map((event){
      final value = VerseAudioModel.fromJson(event?["state"]);
      if(value.runtimeType == VerseAudioModel) {
        return value;
      }
      return null;
    });
  }

  static Stream<AudioAttributeState?> getAudioAttributeStateStream(){
    final service = FlutterBackgroundService();
    return service.on(_sendAttributeState).asBroadcastStream().map((event){
      final value = AudioAttributeState.fromJson(event?["state"]);
      if(value.runtimeType == AudioAttributeState) {
        return value;
      }
      return null;
    });
  }


}


@pragma('vm:entry-point')
Future<void> _notificationTapBackground(ReceivedAction notificationResponse) async {
  SendPort? uiSendPort = IsolateNameServer.lookupPortByName(NotificationAudioVerse.notificationActionIsolateName);
  if (uiSendPort != null) {
    uiSendPort.send(notificationResponse.buttonKeyPressed);
    return;
  }
}