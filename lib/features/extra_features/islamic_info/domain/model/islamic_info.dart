

import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info_item.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info_title.dart';

class IslamicInfo{
  final IslamicInfoTitle infoTitle;
  final List<IslamicInfoItem> infoItems;

  IslamicInfo({required this.infoItems,required this.infoTitle});
}