
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hadith/core/data/preferences/app_preferences_impl.dart';
import 'package:hadith/core/data/repo/save_point_repo_impl.dart';
import 'package:hadith/core/data/repo/verse/get_verses.dart';
import 'package:hadith/core/data/repo/verse/verse_repo_impl.dart';
import 'package:hadith/core/data/services/connectivity_service_impl.dart';
import 'package:hadith/core/data/services/file_service_impl.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/use_cases/save_point/insert_or_update_auto_save_point.dart';
import 'package:hadith/core/features/verse_audio/data/local/verse_audio_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/data/local/verse_downloaded_voice_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/data/local/verse_meal_voice_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/data/manager/quran_download_audio_background_manager_impl.dart';
import 'package:hadith/core/features/verse_audio/data/manager/quran_listen_audio_background_manager_impl.dart';
import 'package:hadith/core/features/verse_audio/data/manager/verse_audio_download_manager_impl.dart';
import 'package:hadith/core/features/verse_audio/data/services/audio_file_editor_impl.dart';
import 'package:hadith/core/features/verse_audio/data/services/quran_download_service_impl.dart';
import 'package:hadith/core/features/verse_audio/data/services/verse_audio_just_service.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_service.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/background_verse_audio_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/quran_download_audio_background_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/quran_listen_audio_foreground_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/id_model.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/service_audio/background_event.dart';
import 'package:hadith/core/features/verse_audio/domain/model/service_audio/background_service_enum_wrapper.dart';
import 'package:hadith/core/features/verse_audio/domain/model/service_audio/foreground_send_data.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/i_verse_download_audio_notification.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/i_verse_listen_audio_notification.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/notification_base.dart';
import 'package:hadith/core/features/verse_audio/domain/services/attach_notification_id_service.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/db/instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundVerseAudioManagerImpl extends BackgroundVerseAudioManager{

  late final ServiceInstance _service;
  late final IVerseListenAudioNotification _listenAudioNotification;
  late final IVerseDownloadAudioNotification _downloadAudioNotification;
  late final AttachNotificationIdService _attachNotificationIdService;

  QuranListenAudioBackgroundManager? _audioBackgroundManager;
  QuranDownloadAudioBackgroundManager? _downloadAudioBackgroundManager;

  StreamSubscription<Map<String, dynamic>?>? _subsAudioStartListener;
  StreamSubscription<Map<String, dynamic>?>? _subsAudioCloseListener;
  StreamSubscription<Map<String, dynamic>?>? _subsAudioDownloadStartListener;
  StreamSubscription<Map<String, dynamic>?>? _subsAudioDownloadCloseListener;
  StreamSubscription<Map<String, dynamic>?>? _subsAudioCheckNotificationListener;

  final List<BackgroundServiceEnumWrapper> _activeServices = [];


  BackgroundVerseAudioManagerImpl({
    required ServiceInstance service,
    required IVerseListenAudioNotification listenAudioNotification,
    required IVerseDownloadAudioNotification downloadAudioNotification,
    required AttachNotificationIdService attachNotificationIdService
  }){
    _service = service;
    _listenAudioNotification = listenAudioNotification;
    _downloadAudioNotification = downloadAudioNotification;
    _attachNotificationIdService = attachNotificationIdService;

    _activeServiceListeners();

    _attachNotificationIdService.setModels(
      models: [
        IdModel(notificationBase: _listenAudioNotification, serviceEnum: AudioServiceEnum.listenAudio),
        IdModel(notificationBase: _downloadAudioNotification, serviceEnum: AudioServiceEnum.downloadAudio),
      ]
    );
  }


  @override
  Future<void> init()async{
    await AwesomeNotifications().setListeners(onActionReceivedMethod: _notificationTapBackground);

    final database = await getDatabase();
    final sharedPreferences = await SharedPreferences.getInstance();

    _audioBackgroundManager = _getListenAudioBackgroundManager(database, sharedPreferences);
    _downloadAudioBackgroundManager = _getQuranDownloadAudioBackgroundManager(database);
  }

  @override
  Future<void> cancel()async{
    await _audioBackgroundManager?.cancel();
    await _downloadAudioBackgroundManager?.cancel();
    _activeServices.clear();
    _notifyActiveServices();

    await _cancelServiceListeners();
  }

  @override
  Future<void> dispose()async{
    await cancel();

    await _audioBackgroundManager?.dispose();
    await _downloadAudioBackgroundManager?.dispose();
    await _listenAudioNotification.dismiss();
    await _downloadAudioNotification.dismiss();
    await _service.stopSelf();
  }

  Future<void> _addActiveService(AudioServiceEnum serviceEnum, NotificationBase notificationBase)async{
    final serviceClass = BackgroundServiceEnumWrapper(serviceEnum: serviceEnum);
    if(!_activeServices.contains(serviceClass)){
      await _attachNotificationIdService.attachId(serviceEnum);
      _activeServices.add(serviceClass);
      _notifyActiveServices();
    }
  }

  Future<void> _removeActiveService(AudioServiceEnum serviceEnum)async{
    _activeServices.remove(BackgroundServiceEnumWrapper(serviceEnum: serviceEnum));
    _notifyActiveServices();
    await _checkServiceShouldBeClosed();

  }

  void _notifyActiveServices(){
    _service.invoke(BackgroundSendData.sendActiveServices,{"data": jsonEncode(_activeServices)});
  }

  Future<void> _cancelListenerService()async{
    await _audioBackgroundManager?.cancel();
    await _attachNotificationIdService.detachId(AudioServiceEnum.listenAudio);
    await _removeActiveService(AudioServiceEnum.listenAudio);
  }

  Future<void> _cancelDownloadService()async{
    await _downloadAudioBackgroundManager?.cancel();
    await _attachNotificationIdService.detachId(AudioServiceEnum.downloadAudio);
    await _removeActiveService(AudioServiceEnum.downloadAudio);
  }


  void _activeServiceListeners()async{
    await _cancelServiceListeners();

    _subsAudioStartListener = _service.on(BackgroundEventStartListenAudio.key).distinct().listen((event) async{
      await _addActiveService(AudioServiceEnum.listenAudio,_listenAudioNotification);
      final audioParam = ListenAudioParam.fromJson(event?["data"]);
      _audioBackgroundManager?.runService(audioParam);
    });

    _subsAudioDownloadStartListener = _service.on(BackgroundEventStartDownloadAudio.key).distinct().listen((event) async{
      await _addActiveService(AudioServiceEnum.downloadAudio, _downloadAudioNotification);
      final audioDownloadParam = DownloadAudioParam.fromJson(event?["data"]);
      _downloadAudioBackgroundManager?.addDownloadQueue(audioDownloadParam);
    });

    _subsAudioCloseListener = _service.on(BackgroundEventStopListenAudio.key).listen((event) async{
      await _audioBackgroundManager?.setFinishPlayer();
    });

    _subsAudioDownloadCloseListener = _service.on(BackgroundEventStopDownloadAudio.key).listen((event) async{
      await _cancelDownloadService();
    });

    _subsAudioCheckNotificationListener = _service.on(BackgroundEventCheckNotificationStatus.key).listen((event) async{
      await _listenAudioNotification.notifyPermissionStatus();
      await _downloadAudioNotification.notifyPermissionStatus();
    });
  }


  Future<void> _checkServiceShouldBeClosed()async{
    EasyDebounce.debounce("cancel_background_service_debounce", Duration(milliseconds: K.service.checkServiceForCancelInMilliSeconds), () async{
      if(_activeServices.isNotEmpty) return;
      await dispose();
    });
  }

  Future<void> _cancelServiceListeners()async{
    await _subsAudioStartListener?.cancel();
    await _subsAudioCloseListener?.cancel();
    await _subsAudioDownloadStartListener?.cancel();
    await _subsAudioDownloadCloseListener?.cancel();
    await _subsAudioCheckNotificationListener?.cancel();
  }

  Future<void> _handleNotificationBase(String key)async{
    if(key == BackgroundEventStopAll.key){
      await dispose();
    }
  }

  QuranListenAudioBackgroundManager _getListenAudioBackgroundManager(
      AppDatabase database,
      SharedPreferences sharedPreferences
      ){
    final insertOrUpdateSavePoint = InsertOrUpdateAutoSavePoint(
        savePointRepo: SavePointRepoImpl(savePointDao: database.savePointDao)
    );
    final getVerses = GetVerses(surahDao: database.surahDao);
    final verseRepo = VerseRepoImpl(verseDao: database.verseDao, getVerses: getVerses);
    final fileService = FileServiceImpl();
    final audioFileEditor = AudioFileEditorImpl();

    final audioService = VerseAudioJustService(
      verseAudioRepo: VerseAudioRepoImpl(verseAudioDao: database.verseAudioDao, fileService: fileService,audioFileEditor: audioFileEditor),
      appPreferences: AppPreferencesImpl(preferences: sharedPreferences),
      fileService: fileService,
      verseVoiceRepo: VerseMealVoiceRepoImpl(
          verseAudioDao: database.verseAudioDao,
          verseDao: database.verseDao,
          getVerses: getVerses,
          editionDao: database.editionDao,
          cuzDao: database.cuzDao
      ),
    );

    return QuranListenAudioBackgroundManagerImpl(
        service: _service,
        insertOrUpdateAutoSavePoint: insertOrUpdateSavePoint,
        audioService: audioService,
        verseRepo: verseRepo,
        notification: _listenAudioNotification,
        handleNotificationBase: _handleNotificationBase,
        onCancel: () async{
          await _cancelListenerService();
        }
    );
  }

  QuranDownloadAudioBackgroundManager _getQuranDownloadAudioBackgroundManager(
      AppDatabase database,
      ){

    final quranDownloadService = QuranDownloadServiceImpl();
    final fileService = FileServiceImpl();
    final audioFileEditor = AudioFileEditorImpl();

    final getVerses = GetVerses(surahDao: database.surahDao);
    final verseAudioRepo = VerseAudioRepoImpl(verseAudioDao: database.verseAudioDao, fileService: fileService,audioFileEditor: audioFileEditor);
    final verseDownloadVerseRepo = VerseDownloadedVoiceRepoImpl(
        verseArabicDao: database.verseArabicDao,
        verseDao: database.verseDao,
        getVerses: getVerses
    );
    final connectivityService = ConnectivityServiceImpl();

    final audioDownloadManager = VerseAudioDownloadManagerImpl(
        quranDownloadService: quranDownloadService,
        verseAudioRepo: verseAudioRepo,
        connectivityService: connectivityService,
        verseDownloadedVoiceRepo: verseDownloadVerseRepo
    );

    return QuranDownloadAudioBackgroundManagerImpl(
        service: _service,
        notification: _downloadAudioNotification,
        audioDownloadManager: audioDownloadManager,
        handleNotificationBase: _handleNotificationBase,
        onCancel: ()async{
          await _cancelDownloadService();
        }
    );
  }
}



@pragma('vm:entry-point')
Future<void> _notificationTapBackground(ReceivedAction notificationResponse) async {
  SendPort? uiSendPort = IsolateNameServer.lookupPortByName(IVerseListenAudioNotification.getIsolateName);
  if (uiSendPort != null) {
    uiSendPort.send(notificationResponse.buttonKeyPressed);
  }

  SendPort? uiSendPort2 = IsolateNameServer.lookupPortByName(IVerseDownloadAudioNotification.getIsolateName);
  if (uiSendPort2 != null) {
    uiSendPort2.send(notificationResponse.buttonKeyPressed);
  }
}