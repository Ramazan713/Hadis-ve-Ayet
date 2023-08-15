

import 'package:hadith/core/data/local/entities/islamic_info/islamic_info_title_entity.dart';
import 'package:hadith/core/domain/enums/islamic_info_type.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_title.dart';

extension IslamicInfoTitleEntityExt on IslamicInfoTitleEntity{

  IslamicInfoTitle toIslamicInfoTitle(){
    return IslamicInfoTitle(
     id: id,
     title: title,
     type: IslamicInfoType.from(type),
     description: description
    );
  }

}