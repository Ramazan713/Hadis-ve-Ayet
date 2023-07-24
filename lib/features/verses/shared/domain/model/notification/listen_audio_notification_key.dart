

import 'package:hadith/features/verses/shared/domain/model/notification/i_notification_key.dart';

class ListenAudioNotificationKey extends INotificationKey{

  final String continueKey = "listenAudioContinueKey";
  final String continueTitle = "devam et";

  final String pauseKey = "listenAudioPauseKey";
  final String pauseTitle = "durdur";

  final String cancelKey = "listenAudioCancelKey";
  final String cancelTitle = "iptal et";

}
