

import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/islamic_info/data/entity/islamic_info_item_entity.dart';
import 'package:hadith/features/extra_features/islamic_info/data/entity/islamic_info_title_entity.dart';

@dao
abstract class IslamicInfoDaoOld{

  @Query("select * from islamicInfoTitle where type=:type")
  Future<List<IslamicInfoTitleEntityOld>> getIslamicInfoTitlesByTypeId(int type);

  @Query("select * from islamicInfoItem where titleId=:titleId")
  Future<List<IslamicInfoItemEntityOld>> getIslamicInfoItemsByTitleId(int titleId);

}