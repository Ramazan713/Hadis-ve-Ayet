

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hadith/features/verses/shared/domain/enums/download_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/notification/download_audio_notification_key.dart';
import 'package:hadith/features/verses/shared/domain/model/notification/i_notification_key.dart';
import 'package:meta/meta.dart';

import '../model/download_verse/download_audio_manager_state.dart';


abstract class NotificationBase<T, Y extends INotificationKey>{


  int _notificationId = 1;
  int get notificationId => _notificationId;
  set notificationId(value){
    _notificationId = value;
  }

  abstract String notificationChannelKey;
  abstract String channelDescription;
  abstract String isolateName;

  abstract Y notificationKeys;

  var _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;


  static const List<NotificationPermission> getDefaultNotificationPermissionList = [NotificationPermission.Badge, NotificationPermission.Light];


  @nonVirtual
  final List<NotificationPermission> notificationPermissionList = getDefaultNotificationPermissionList;

  @nonVirtual
  Future<void> notifyPermissionStatus()async{
    await _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async{
    _isNotificationEnabled = await checkPermission();
  }

  Future<bool> checkPermission();

  Future<void> requestPermission();

  @protected
  Future<void> initChannel();

  Future<void> showDefaultNotification({T? data});

  Future<void> showNotification(T data);

  Future<void> showInitNotification();

  Future<void> dismiss();

}