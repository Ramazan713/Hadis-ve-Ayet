

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/listen_audio_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/i_verse_listen_audio_notification.dart';

class VerseListenAudioNotificationImpl extends IVerseListenAudioNotification{

  @override
  List<NotificationActionButton>? doNotificationButtons(ListenAudioServiceState state){
    final buttons = <NotificationActionButton>[];

    if(state.audioEnum == ListenAudioEnum.running){
      buttons.add(NotificationActionButton(
          key: notificationKeys.pauseKey,
          label: notificationKeys.pauseTitle,
          actionType: ActionType.SilentBackgroundAction,
          showInCompactView: true,
          autoDismissible: false
      ));
    }else if(state.audioEnum == ListenAudioEnum.pause){
      buttons.add(NotificationActionButton(
          key: notificationKeys.continueKey,
          label: notificationKeys.continueTitle,
          actionType: ActionType.SilentBackgroundAction,
          showInCompactView: true,
          autoDismissible: false
      ));
    }
    buttons.add( NotificationActionButton(
        key: notificationKeys.cancelKey,
        label: notificationKeys.cancelTitle,
        isDangerousOption: true,
        actionType: ActionType.SilentBackgroundAction,
        showInCompactView: true,
        autoDismissible: false));

    return buttons;
  }

  @override
  NotificationContent doNotificationContent(ListenAudioServiceState state) {
    return NotificationContent(
      id: notificationId,
      channelKey: notificationChannelKey,
      body: state.getInfo(),
      notificationLayout: NotificationLayout.Default,
      category: NotificationCategory.Service,
      displayOnForeground: true,
      autoDismissible: false,
    );
  }


}