
import 'package:flutter/material.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';

class K{
  static const List<SavePointType> allowedAutoSavePointTypes = [
    SavePointType.all, SavePointType.cuz
  ];

  static const searchDelaySearchMilliSecond = 300;


  static const service = ServiceK();
  static const backup = BackupK();
  static const actKeys = ActionResultKeysK();
  static const urls = UrlK();
  static const ad = AdK();

  static const timeOutSeconds = 13;

  static const double searchBarHeight = 80;
  static const int searchResultCollectionSize = 7;

  static const int hadithPageSize = 19;
  static const int hadithPagingPrefetchSize = 5;
  static const int hadithMaxContentLengthSize = 700;

  static const int versePageSize = 19;
  static const int versePagingPrefetchSize = 5;

  static const int delayForStartingServiceInMilliSeconds = 2000;

  static const defaultLazyListPadding = EdgeInsets.only(top: 4, bottom: 12);

}

class ServiceK{
  final int checkServiceForCancelInMilliSeconds = 1000;
  final int resetDownloadStateInMilli = 70;
  final int delayForResetDownloadStateInMilli = 30;

  const ServiceK();
}

class BackupK{
  final autoMaxBackups = 1;
  final nonAutoMaxBackups = 2;
  final waitingRefreshTime = 60;

  const BackupK();
}

class ActionResultKeysK{
  final String uploadBackupForSignOut = "uploadBackupForSignOut";

  const ActionResultKeysK();
}

class AdK{
  final int tickIntervalSeconds = 3;
  final int thresholdConsumeSeconds = 210;//3m 30s
  final int thresholdOpeningCounter = 19;

  const AdK();
}

class UrlK{
  final playStoreDetailUrl = "https://play.google.com/store/apps/details";
  final playStoreSubsUrl = "https://play.google.com/store/account/subscriptions";


  const UrlK();
}

