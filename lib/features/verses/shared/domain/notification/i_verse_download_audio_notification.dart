

import 'package:meta/meta.dart';

import '../model/download_verse/download_audio_manager_state.dart';
import 'awesome_notification_base.dart';
import '../model/notification/download_audio_notification_key.dart';
import 'notification_base.dart';

abstract class IVerseDownloadAudioNotification
    extends AwesomeNotificationBase<DownloadAudioManagerState, DownloadAudioNotificationKey>
{

  static const String getNotificationChannelKey = "download_audio_verse_channel";
  static const String getIsolateName = "download_audio_verse_isolate_name";


  static Future<bool> requestNotificationPermission()async{
    return await AwesomeNotificationBase.requestNotificationPermission(channelKey: getNotificationChannelKey);
  }

  @override
  String channelDescription = "ayetlerin indirilmesi için kullanılır";

  @nonVirtual
  @override
  String notificationChannelKey = getNotificationChannelKey;

  @nonVirtual
  @override
  String isolateName = getIsolateName;

  @override
  DownloadAudioNotificationKey notificationKeys = DownloadAudioNotificationKey();

  @override
  DownloadAudioManagerState get defaultData => DownloadAudioManagerState.init();

}