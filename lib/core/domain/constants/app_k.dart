

import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';

class K{
  static const List<SavePointType> allowedAutoSavePointTypes = [
    SavePointType.all, SavePointType.cuz
  ];

  static const ServiceK service = ServiceK();

  static const int hadithPageSize = 19;
  static const int hadithPagingPrefetchSize = 5;

  static const int versePageSize = 19;
  static const int versePagingPrefetchSize = 5;

  static const int delayForStartingServiceInMilliSeconds = 2000;

}

class ServiceK{
  final int checkServiceForCancelInMilliSeconds = 1000;
  final int resetDownloadStateInMilli = 70;
  final int delayForResetDownloadStateInMilli = 30;

  const ServiceK();
}