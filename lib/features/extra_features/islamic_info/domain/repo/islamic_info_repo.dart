

import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info.dart';

abstract class IslamicInfoRepo{

  Future<List<IslamicInfo>> islamicInfosByType(IslamicInfoType type);
}