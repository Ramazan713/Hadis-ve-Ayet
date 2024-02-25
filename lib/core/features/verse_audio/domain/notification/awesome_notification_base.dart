

import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/notification_base.dart';
import 'package:meta/meta.dart';

import '../model/service_audio/background_event.dart';
import 'i_verse_download_audio_notification.dart';
import 'i_verse_listen_audio_notification.dart';
import '../model/notification/i_notification_key.dart';

abstract class AwesomeNotificationBase<T, Y extends INotificationKey> extends NotificationBase<T, Y>{

  T? _prevNotification;

  static Future<bool> requestNotificationPermission({
      required String channelKey,
      List<NotificationPermission> permissions = NotificationBase.getDefaultNotificationPermissionList
  }) async{
    return await AwesomeNotifications()
        .requestPermissionToSendNotifications(channelKey: channelKey,permissions: permissions);
  }

  static Future<bool> shouldShowRationaleToRequestForNotification({
    required String channelKey,
    List<NotificationPermission> permissions = NotificationBase.getDefaultNotificationPermissionList
  }) async{
    return (await AwesomeNotifications()
        .shouldShowRationaleToRequest(channelKey: channelKey, permissions: permissions)).isNotEmpty;
  }

  @override
  Future<bool> shouldShowRationaleToRequest() async{
    return shouldShowRationaleToRequestForNotification(channelKey: notificationChannelKey, permissions: notificationPermissionList);
  }

  @nonVirtual
  @override
  Future<bool> checkPermission()async{
    try{
      return (await AwesomeNotifications()
          .checkPermissionList(channelKey: notificationChannelKey,permissions: notificationPermissionList)).isNotEmpty;
    }catch(e){
      return false;
    }
  }

  @nonVirtual
  @override
  Future<void> requestPermission()async{
    await AwesomeNotifications()
        .requestPermissionToSendNotifications(channelKey: notificationChannelKey,permissions: notificationPermissionList);
  }



  @protected
  NotificationContent doNotificationContent(T state);

  @protected
  List<NotificationActionButton>? doNotificationButtons(T state);

  T get defaultData;

  @override
  Future<void> showDefaultNotification({T? data}) async{
    final currentData = data ?? _prevNotification ?? defaultData;
    await showNotification(currentData);
  }

  @override
  Future<void> showNotification(T data) async{
    if(isNotificationEnabled){
      _prevNotification = data;
      await AwesomeNotifications().createNotification(
          content: doNotificationContent(data),
          actionButtons: doNotificationButtons(data)
      );
    }
  }

  @nonVirtual
  @override
  Future<void> initChannel() async{
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: IVerseDownloadAudioNotification.getNotificationChannelKey,
        channelName: IVerseDownloadAudioNotification.getNotificationChannelKey,
        enableVibration: false,
        playSound: false,
        importance: NotificationImportance.Default,
        channelDescription: channelDescription,
      ),
      NotificationChannel(
        channelKey: IVerseListenAudioNotification.getNotificationChannelKey,
        channelName: IVerseListenAudioNotification.getNotificationChannelKey,
        enableVibration: false,
        playSound: false,
        importance: NotificationImportance.Default,
        channelDescription: channelDescription,
      )
    ],debug: true);
  }


  @override
  Future<void> showInitNotification() async{
    if(await checkPermission()){
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: notificationId,
            channelKey: notificationChannelKey,
            title: "service başlatılıyor",
          ),
          actionButtons: [
            NotificationActionButton(
                key: BackgroundEventStopAll.key,
                label: "iptal et",
                isDangerousOption: true,
                actionType: ActionType.SilentBackgroundAction,
                autoDismissible: false
            ),
          ]
      );
    }
  }

  @override
  Future<void> dismiss() async{
    await AwesomeNotifications().cancel(notificationId);
  }

}
