

import 'package:hadith/core/data/local/services/islamic_info_dao.dart';
import 'package:hadith/features/islamic_info/shared/data/mapper/islamic_info_item_mapper.dart';
import 'package:hadith/features/islamic_info/shared/data/mapper/islamic_info_title_mapper.dart';
import 'package:hadith/core/domain/enums/islamic_info_type.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_collection.dart';
import 'package:hadith/features/islamic_info/shared/domain/repo/islamic_info_repo.dart';

class IslamicInfoRepoImpl extends IslamicInfoRepo{

  late final IslamicInfoDao _infoDao;

  IslamicInfoRepoImpl({
    required IslamicInfoDao infoDao
  }){
    _infoDao = infoDao;
  }

  @override
  Future<List<IslamicInfoCollection>> getIslamicInfoCollectionByType(IslamicInfoType type) async{

    final result = <IslamicInfoCollection>[];

    final titleEntities = await _infoDao.getIslamicInfoTitlesByTypeId(type.typeId);

    for(final title in titleEntities){
      final itemsEntity = await _infoDao.getIslamicInfoItemsByTitleId(title.id ?? 0);
      final collection = IslamicInfoCollection(
          infoTitle: title.toIslamicInfoTitle(),
          infoItems: itemsEntity.map((e) => e.toIslamicInfoItem()).toList()
      );
      result.add(collection);
    }

    return result;
  }

}