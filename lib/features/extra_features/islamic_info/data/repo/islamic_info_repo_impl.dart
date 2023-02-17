

import 'package:hadith/features/extra_features/islamic_info/data/islamic_info_dao.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/repo/islamic_info_repo.dart';

class IslamicInfoRepoImpl extends IslamicInfoRepo{

  late final IslamicInfoDao _infoDao;
  IslamicInfoRepoImpl({required IslamicInfoDao infoDao}){
    _infoDao = infoDao;
  }

  @override
  Future<List<IslamicInfo>> islamicInfosByType(IslamicInfoType type) async{
    final titles = (await _infoDao.getIslamicInfoTitlesByTypeId(type.typeId))
        .map((e) => e.toIslamicInfoTitle()).toList();

    final islamicInfos = <IslamicInfo>[];

    for(final title in titles){
      final items = (await _infoDao.getIslamicInfoItemsByTitleId(title.id??0))
          .map((e) => e.toIslamicInfoItem()).toList();
      islamicInfos.add(IslamicInfo(infoItems: items, infoTitle: title));
    }
    return islamicInfos;
  }

}