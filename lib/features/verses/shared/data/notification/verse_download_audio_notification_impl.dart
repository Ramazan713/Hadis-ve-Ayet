

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hadith/features/verses/shared/domain/enums/download_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/features/verses/shared/domain/notification/awesome_notification_base.dart';
import 'package:hadith/features/verses/shared/domain/model/notification/download_audio_notification_key.dart';
import 'package:hadith/features/verses/shared/domain/notification/i_verse_download_audio_notification.dart';

class VerseDownloadAudioNotificationImpl extends IVerseDownloadAudioNotification{

  @override
  NotificationContent doNotificationContent(DownloadAudioManagerState state) {
    return NotificationContent(
        id: notificationId,
        channelKey: notificationChannelKey,
        body: state.getBodyContent,
        progress: state.getProgress100,
        notificationLayout: NotificationLayout.ProgressBar,
        category: NotificationCategory.Progress,
        displayOnForeground: true,
        autoDismissible: false,
      );
  }


  @override
  List<NotificationActionButton>? doNotificationButtons(DownloadAudioManagerState state) {
    final buttons = <NotificationActionButton>[];

    if(state.downloadEnum == DownloadEnum.downloading){
      buttons.add(NotificationActionButton(
          key: notificationKeys.pauseKey,
          label: notificationKeys.pauseTitle,
          actionType: ActionType.SilentBackgroundAction,
          autoDismissible: false
      ));
    }else if(state.downloadEnum == DownloadEnum.pause){
      buttons.add(NotificationActionButton(
          key: notificationKeys.continueKey,
          label: notificationKeys.continueTitle,
          actionType: ActionType.SilentBackgroundAction,
          autoDismissible: false));
    }else if(state.downloadEnum == DownloadEnum.retry){
      buttons.add(NotificationActionButton(
          key: notificationKeys.retryKey,
          label: notificationKeys.retryTitle,
          actionType: ActionType.SilentBackgroundAction,
          autoDismissible: false));
    }

    buttons.add( NotificationActionButton(
        key: notificationKeys.cancelKey,
        label: notificationKeys.cancelTitle,
        isDangerousOption: true,
        actionType: ActionType.SilentBackgroundAction,
        autoDismissible: false));

    return buttons;
  }

}