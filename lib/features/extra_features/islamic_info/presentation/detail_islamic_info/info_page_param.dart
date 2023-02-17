
import 'package:flutter/material.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';

class InfoPageParam{
  final IslamicInfoType infoType;
  final Axis itemAxis;
  InfoPageParam({required this.infoType,required this.itemAxis});

  static InfoPageParam defaultParam(){
    return InfoPageParam(
      infoType: IslamicInfoType.none,
      itemAxis: Axis.vertical
    );
  }
}