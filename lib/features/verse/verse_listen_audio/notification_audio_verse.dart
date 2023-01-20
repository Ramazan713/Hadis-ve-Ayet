

import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/verse_audio_model.dart';
import 'package:hadith/utils/i_notification.dart';

class NotificationAudioVerse extends INotification<VerseAudioModel>{

  static const String notificationActionIsolateName="background_notification_audio";


  static const String pauseButton = "pauseButton";
  static const String cancelButton = "cancelButton";
  static const String continueButton = "continueButton";

  @override
  Future<void> doInitListeners(Future<void> Function(ReceivedAction) onActionReceivedMethod) async{
    await AwesomeNotifications().setListeners(onActionReceivedMethod:onActionReceivedMethod);
  }

  @override
  Future<void> doShowNotification(VerseAudioModel data) async{
    await AwesomeNotifications().createNotification(
        content: _getNotificationContent(data),
        actionButtons:_getNotificationButtons(data));
  }

  NotificationContent _getNotificationContent(VerseAudioModel state){

    return NotificationContent(
      id: INotification.notificationId, // -1 is replaced by a random number
      channelKey: INotification.notificationChannelKey,
      body: state.getInfo(),
      notificationLayout: NotificationLayout.Default,
      category: NotificationCategory.Service,
      displayOnForeground: true,
      autoDismissible: false,
    );
  }

  List<NotificationActionButton>? _getNotificationButtons(VerseAudioModel state){
    final buttons = <NotificationActionButton>[];

    if(state.audioEnum == AudioEnum.running){
      buttons.add(NotificationActionButton(
          key: pauseButton,
          label: "durdur",
          actionType: ActionType.SilentBackgroundAction,
          autoDismissible: false
      ));
    }else if(state.audioEnum == AudioEnum.pause){
      buttons.add(NotificationActionButton(
          key: continueButton,
          label: 'devam et',
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