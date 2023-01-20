import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/features/verse/verse_download_audio/services/quran_download_foreground_service.dart';
import 'package:hadith/features/verse/verse_listen_audio/services/quran_audio_foreground_service.dart';
import 'package:hadith/utils/i_notification.dart';

class ForegroundServiceHelper{

  static Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await INotification.initChannel();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        autoStartOnBoot: false,
        notificationChannelId: INotification.notificationChannelKey,
        initialNotificationTitle: 'hadis ve ayet service',
        initialNotificationContent: 'başlatılıyor',
        foregroundServiceNotificationId: INotification.notificationId,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    if(await service.isRunning()){
      service.startService();
      if(!await INotification.checkPermission()){
        await Future.delayed(const Duration(seconds: kDelayForStartingServiceInSeconds));
        service.invoke("stopSelf");
      }
    }

  }

  static Future<void> startService()async{
    final service = FlutterBackgroundService();
    if(!await service.isRunning()){
      await service.startService();
    }
  }

  static Future<void> stopService()async{
    final service = FlutterBackgroundService();
    if(await service.isRunning()){
      service.invoke("stopSelf");
    }
  }




  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    INotification.showInitNotification();

    StreamSubscription<Map<String, dynamic>?>?subsStop;

    Future<void> closeService()async{
      service.invoke("serviceClose");
      await service.stopSelf();
      await subsStop?.cancel();
    }

    final audioService = QuranAudioForegroundService(service: service,onCancel: ()async{
      await closeService();
    });

    final downloadService = QuranDownloadForegroundService(service: service, onCancel: ()async{
      await closeService();
    });

    subsStop = service.on("stopSelf").listen((event) async{
      await audioService.dispose();
      await downloadService.dispose();
      await closeService();
    });



  }

  static Future<bool> isServiceRunning()async{
    return FlutterBackgroundService().isRunning();
  }

  static Stream<void> serviceCloseStream(){
    return FlutterBackgroundService().on("serviceClose");
  }

}