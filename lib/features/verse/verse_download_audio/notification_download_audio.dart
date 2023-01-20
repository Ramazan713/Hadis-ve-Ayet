
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hadith/features/verse/verse_download_audio/constants/download_enum.dart';
import 'package:hadith/features/verse/verse_download_audio/models/download_voice_service_state.dart';
import '../../../utils/i_notification.dart';

class NotificationDownloadAudio extends INotification<DownloadVoiceServiceState>{
  static const String notificationActionIsolateName="background_notification_action";


  static const String pauseButton = "pauseButton";
  static const String cancelButton = "cancelButton";
  static const String continueButton = "continueButton";
  static const String retryButton = "retryButton";

  @override
  Future<void> doInitListeners(onActionReceivedMethod) async{
    await AwesomeNotifications().setListeners(onActionReceivedMethod:onActionReceivedMethod);
  }

  @override
  Future<void> doShowNotification(DownloadVoiceServiceState data) async{
    await AwesomeNotifications().createNotification(
        content: _getNotificationContent(data),
        actionButtons:_getNotificationButtons(data));
  }


  NotificationContent _getNotificationContent(DownloadVoiceServiceState state){
    return NotificationContent(
      id: INotification.notificationId, // -1 is replaced by a random number
      channelKey: INotification.notificationChannelKey,
      body: state.getBodyContent(),
      progress: state.getProgress100(),
      notificationLayout: NotificationLayout.ProgressBar,
      category: NotificationCategory.Progress,
      displayOnForeground: true,
      autoDismissible: false,
    );
  }

  List<NotificationActionButton>? _getNotificationButtons(DownloadVoiceServiceState state){
    final buttons = <NotificationActionButton>[];

    if(state.downloadEnum == DownloadEnum.downloading){
      buttons.add(NotificationActionButton(
          key: pauseButton,
          label: "durdur",
          actionType: ActionType.SilentBackgroundAction,
          autoDismissible: false
      ));
    }else if(state.downloadEnum == DownloadEnum.pause){
      buttons.add(NotificationActionButton(
          key: continueButton,
          label: 'devam et',
          actionType: ActionType.SilentBackgroundAction,
          autoDismissible: false));
    }else if(state.downloadEnum == DownloadEnum.retry){
      buttons.add(NotificationActionButton(
          key: retryButton,
          label: 'tekrar dene',
          actionType: ActionType.SilentBackgroundAction,
          autoDismissible: false));
    }
    buttons.add( NotificationActionButton(
        key: cancelButton,
        label: 'iptal et',
        isDangerousOption: true,
        actionType: ActionType.SilentBackgroundAction,
        autoDismissible: false));

    return buttons;
  }
}