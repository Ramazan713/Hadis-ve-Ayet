

import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hadith/db/instance.dart';
import 'package:hadith/db/repos/audio_edition_repo.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/db/repos/verse_audio_state_repo.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/features/verse/verse_download_audio/models/download_voice_service_state.dart';
import 'package:hadith/features/verse/verse_download_audio/services/quran_download_manager.dart';
import 'package:hadith/features/verse/verse_download_audio/services/quran_download_service.dart';
import 'package:hadith/features/verse/verse_download_audio/notification_download_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/download_enum.dart';

class QuranDownloadForegroundService{

  final NotificationDownloadAudio _notification = NotificationDownloadAudio();

  static const String _startDownloading = "_startDownloading";
  static const String _downloadState = "_downloadState";
  static const String _resumeDownloading = "_resumeDownloading";
  static const String _pauseDownloading = "_pauseDownloading";
  static const String _cancelDownloading = "_cancelDownloading";
  static const String _retryDownloading = "_retryDownloading";

  StreamSubscription<DownloadVoiceServiceState>? _subsState;
  StreamSubscription<Map<String, dynamic>?>? _subsEvents;
  StreamSubscription<dynamic>? _subsPort;

  StreamSubscription<Map<String, dynamic>?>? _subsDownloadEvents;
  StreamSubscription<Map<String, dynamic>?>? _subsResumeEvents;
  StreamSubscription<Map<String, dynamic>?>? _subsPauseEvents;
  StreamSubscription<Map<String, dynamic>?>? _subsCancelEvents;
  StreamSubscription<Map<String, dynamic>?>? _subsRetryEvents;

  late final Future Function()_onCancel;
  late final ServiceInstance _service;

  QuranDownloadManager?_downloadManager;

  QuranDownloadForegroundService({required ServiceInstance service,required Future Function()onCancel}){
    _onCancel = onCancel;
    _service = service;

    _listenInit();
  }


  Future<void> runService(AudioParam audioParam)async{
    await _notification.initListeners(_notificationTapBackground);

    _downloadManager = await _getDownloadManager();
    _listenNotificationButtons();
    await _listenStateChangeAndSend();

    _downloadManager?.startDownload(audioParam);
    await _notification.showNotification(DownloadVoiceServiceState.init());

  }

  void _listenInit(){
    _subsDownloadEvents = _service.on(_startDownloading).listen((event) async{
      final AudioParam audioParam = AudioParam.fromJson(event?["audioParam"]);

      await runService(audioParam);
    });
  }

  Future<void> _listenStateChangeAndSend()async{
    await _cancelListeners();

    _subsState=_downloadManager?.broadcastListener?.listen((event) async{
      _service.invoke(_downloadState,{"state":event.toJson()});
      if(event.downloadEnum == DownloadEnum.success){
        await _callOnCancel();
      }else{
        await _notification.showNotification(event);
      }
    });


    _subsCancelEvents = _service.on(_cancelDownloading).listen((event) async{
      await _callOnCancel();
    });

    _subsResumeEvents = _service.on(_resumeDownloading).listen((event) async{
      _downloadManager?.resume();
    });

    _subsPauseEvents = _service.on(_pauseDownloading).listen((event) async{
      _downloadManager?.pause();
    });

    _subsRetryEvents = _service.on(_retryDownloading).listen((event) async{
      _downloadManager?.retry();
    });
  }

  void _listenNotificationButtons(){

    ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      NotificationDownloadAudio.notificationActionIsolateName,
    );

    _subsPort=port.listen((received) async {
      switch(received){
        case NotificationDownloadAudio.continueButton:
          _downloadManager?.resume();
          break;
        case NotificationDownloadAudio.pauseButton:
          _downloadManager?.pause();
          break;
        case NotificationDownloadAudio.cancelButton:
          await _callOnCancel.call();
          break;
        case NotificationDownloadAudio.retryButton:
          _downloadManager?.retry();
          break;
      }
    });
  }


  Future<QuranDownloadManager> _getDownloadManager()async{
    final database = await getDatabase();
    final verseAudioStateRepo = VerseAudioStateRepo(audioStateDao: database.verseAudioStateDao);
    final audioRepo = VerseAudioRepo(verseAudioDao: database.verseAudioDao);
    final quranService = QuranDownloadService(audioRepo: audioRepo);
    final editionRepo = AudioEditionRepo(editionDao: database.editionDao,downloadService: quranService);
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final downloadManager = QuranDownloadManager(verseAudioStateRepo: verseAudioStateRepo, audioEditionRepo: editionRepo,
        quranService: quranService,sharedPreferences: sharedPreferences);
    return downloadManager;
  }

  Future<void>_callOnCancel()async{
    await _downloadManager?.cancel();
    await _onCancel.call();
    await dispose();
  }

  Future<void>_cancelListeners()async{
    await _subsState?.cancel();
    await _subsCancelEvents?.cancel();
    await _subsResumeEvents?.cancel();
    await _subsPauseEvents?.cancel();
    await _subsRetryEvents?.cancel();
  }

  Future<void> dispose()async{
    IsolateNameServer.removePortNameMapping(NotificationDownloadAudio.notificationActionIsolateName);
    await _downloadManager?.cancel();
    await _cancelListeners();
    await _subsEvents?.cancel();
    await _subsPort?.cancel();
    await _subsDownloadEvents?.cancel();
  }

  static void startDownloadingVoices(AudioParam audioParam)async{
    final service = FlutterBackgroundService();
    service.invoke(_startDownloading,{"audioParam": audioParam.toJson()});
  }

  static void resume(){
    FlutterBackgroundService().invoke(_resumeDownloading);
  }
  static void pause(){
    FlutterBackgroundService().invoke(_pauseDownloading);
  }

  static void cancel(){
    FlutterBackgroundService().invoke(_cancelDownloading);
  }
  static void retry(){
    FlutterBackgroundService().invoke(_retryDownloading);
  }

  static Stream<DownloadVoiceServiceState?> getStateStream(){
    final service = FlutterBackgroundService();
    return service.on(_downloadState).asBroadcastStream().map((event){
      final value = DownloadVoiceServiceState.fromJson(event?["state"]);
      if(value.runtimeType == DownloadVoiceServiceState) {
        return value;
      }
      return null;
    });
  }

}


@pragma('vm:entry-point')
Future<void> _notificationTapBackground(ReceivedAction notificationResponse) async {
  SendPort? uiSendPort = IsolateNameServer.lookupPortByName(NotificationDownloadAudio.notificationActionIsolateName);
  if (uiSendPort != null) {
    uiSendPort.send(notificationResponse.buttonKeyPressed);
    return;
  }
}

