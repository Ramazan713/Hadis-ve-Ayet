

import 'package:hadith/core/data/local/entities/islamic_info/islamic_info_item_entity.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_item.dart';

extension IslamicInfoItemEntityExt on IslamicInfoItemEntity{

  IslamicInfoItem toIslamicInfoItem(){
    return IslamicInfoItem(
        id: id,
        name: name,
        titleId: titleId,
        description: description
    );
  }
}