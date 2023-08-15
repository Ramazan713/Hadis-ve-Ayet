

import 'package:hadith/core/domain/enums/islamic_info_type.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_collection.dart';

abstract class IslamicInfoRepo{
  Future<List<IslamicInfoCollection>> getIslamicInfoCollectionByType(IslamicInfoType type);
}