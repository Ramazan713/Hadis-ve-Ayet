

import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:hadith/features/verse/verse_download_audio/notification_download_audio.dart';
import 'package:hadith/features/verses/shared/data/manager/background_verse_audio_manager_impl.dart';
import 'package:hadith/features/verses/shared/data/notification/verse_download_audio_notification_impl.dart';
import 'package:hadith/features/verses/shared/data/notification/verse_listen_audio_notification.dart';
import 'package:hadith/features/verses/shared/data/services/attach_notification_id_service_impl.dart';
import 'package:hadith/features/verses/shared/domain/manager/background_verse_audio_manager.dart';
import 'package:hadith/features/verses/shared/domain/model/service_audio/background_event.dart';
import 'package:hadith/features/verses/shared/domain/notification/i_verse_download_audio_notification.dart';
import 'package:hadith/features/verses/shared/domain/notification/i_verse_listen_audio_notification.dart';
import 'package:hadith/features/verses/shared/domain/notification/notification_base.dart';
import 'package:hadith/features/verses/shared/domain/services/attach_notification_id_service.dart';

class BackgroundServiceManager{

  static Future<void> initService() async {

    final service = FlutterBackgroundService();

    final listenVerseNotification = VerseListenAudioNotificationImpl();
    await listenVerseNotification.initChannel();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        autoStartOnBoot: false,
        notificationChannelId: listenVerseNotification.notificationChannelKey,
        initialNotificationTitle: 'hadis ve ayet servisi',
        initialNotificationContent: 'başlatılıyor',
        foregroundServiceNotificationId: AttachNotificationIdService.defaultNotificationId,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );

    if(await service.isRunning()){
      service.startService();
    }

  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {

    DartPluginRegistrant.ensureInitialized();

    final backgroundVerseAudioManager = BackgroundVerseAudioManagerImpl(
        service: service,
        attachNotificationIdService: AttachNotificationIdServiceImpl(),
        downloadAudioNotification: VerseDownloadAudioNotificationImpl(),
        listenAudioNotification: VerseListenAudioNotificationImpl()
    );

    await backgroundVerseAudioManager.init();
  }
}
