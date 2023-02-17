

import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';

class IslamicInfoTitle{

  final int?id;
  final String title;
  final String? description;
  final IslamicInfoType type;

  IslamicInfoTitle({this.id,required this.title,required this.type,
    this.description
  });


}