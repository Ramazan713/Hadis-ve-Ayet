

import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';

class K{
  static const List<SavePointType> allowedAutoSavePointTypes = [
    SavePointType.all, SavePointType.cuz
  ];

  static const int hadithPageSize = 19;
  static const int hadithPagingPrefetchSize = 5;

  static const int versePageSize = 19;
  static const int versePagingPrefetchSize = 5;



}