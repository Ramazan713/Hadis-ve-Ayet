

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:meta/meta.dart';

abstract class INotification<T>{
  static const int notificationId=888;
  static const String notificationChannelKey = "verse_audio_and_download_key";

  bool isEnabled=true;

  void setEnableNotification(bool isEnabled){
    this.isEnabled = isEnabled;
  }

  Future<void> checkAndSetEnableNotification()async{
    isEnabled = await checkPermission();
  }

  Future<void>initListeners(Future<void> Function(ReceivedAction) onActionReceivedMethod)async{
    await checkAndSetEnableNotification();
    await doInitListeners(onActionReceivedMethod);
  }

  @protected
  Future<void> doInitListeners(Future<void> Function(ReceivedAction) onActionReceivedMethod);

  Future<void> showNotification(T data)async{
    if(isEnabled){
      await doShowNotification(data);
    }
  }

  @protected
  Future<void> doShowNotification(T data);

  static void showInitNotification()async{
    if(await checkPermission()){
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: notificationId,
            channelKey: notificationChannelKey,
            title: "service başlatılıyor"
        ),
      );
    }
  }

  static Future<void> initChannel()async{
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(channelKey: notificationChannelKey,
          channelName: notificationChannelKey,
          enableVibration: false,
          playSound: false,
          importance: NotificationImportance.Default,
          channelDescription: "ayetlerin indirilmesinde ve dinlenmesinde kullanılır")
    ]);
  }

  static const List<NotificationPermission> permissions =
  [NotificationPermission.Badge, NotificationPermission.Light];

  static Future<bool> checkPermission()async{
    return (await AwesomeNotifications().checkPermissionList(channelKey: INotification.notificationChannelKey,permissions: permissions)).isNotEmpty;
  }

  static Future<void> requestPermission()async{
    await AwesomeNotifications().requestPermissionToSendNotifications(channelKey: INotification.notificationChannelKey,permissions: permissions);
  }

}