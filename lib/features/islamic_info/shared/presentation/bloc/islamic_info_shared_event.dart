


import 'package:hadith/core/domain/enums/islamic_info_type.dart';

abstract class IIslamicInfoSharedEvent{}

class IslamicInfoSharedEventLoadData extends IIslamicInfoSharedEvent{
  final IslamicInfoType infoType;
  IslamicInfoSharedEventLoadData({required this.infoType});
}

class IslamicInfoSharedEventListenAppPref extends IIslamicInfoSharedEvent{}