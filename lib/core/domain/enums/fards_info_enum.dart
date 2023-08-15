

import 'package:hadith/core/domain/enums/islamic_info_type.dart';

enum FardsInfoEnum{
  f32(
    typeId: 1,
    infoType: IslamicInfoType.fards32
  ),
  f54(
      typeId: 2,
      infoType: IslamicInfoType.fards54
  );

  const FardsInfoEnum({required this.typeId,required this.infoType});

  final IslamicInfoType infoType;
  final int typeId;

  static FardsInfoEnum from(int typeId){
    if(typeId == FardsInfoEnum.f32.typeId){
      return FardsInfoEnum.f32;
    }
    return FardsInfoEnum.f54;
  }
}