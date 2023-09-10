
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:meta/meta.dart';

import 'awesome_notification_base.dart';
import '../model/notification/listen_audio_notification_key.dart';

abstract class IVerseListenAudioNotification extends AwesomeNotificationBase<ListenAudioServiceState, ListenAudioNotificationKey>{


  static const String getNotificationChannelKey = "verse_audio_channel";
  static const String getIsolateName = "listen_audio_verse_isolate_name";


  static Future<bool> requestNotificationPermission()async{
    return await AwesomeNotificationBase.requestNotificationPermission(channelKey: getNotificationChannelKey);
  }

  @override
  String channelDescription = "ayetlerin sesli olarak dinlenilmesi için kullanılır.";

  @nonVirtual
  @override
  String notificationChannelKey = getNotificationChannelKey;

  @nonVirtual
  @override
  String isolateName = getIsolateName;

  @override
  ListenAudioNotificationKey notificationKeys = ListenAudioNotificationKey();

  @override
  ListenAudioServiceState get defaultData => ListenAudioServiceState.init();
}