

import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

enum FontSizeEnum with IMenuItem, IPrefEnum{
  verySmall(
    size: 12,
    description: "Çok Küçük",
    enumValue: 1
  ),
  small(
    size: 14,
    description: "Küçük",
    enumValue: 2
  ),
  medium(
    size: 18,
    description: "Orta",
    enumValue: 3
  ),
  large(
    size: 22,
    description: "Büyük",
    enumValue: 4
  ),
  veryLarge(
    size: 27,
    description: "Çok Büyük",
    enumValue: 5
  );

  const FontSizeEnum({
    required this.size,
    required this.description,
    required this.enumValue
  });

  final double size;
  final String description;
  @override
  final int enumValue;

  @override
  get title => description;

  @override
  get iconInfo => null;

  static FontSizeEnum get defaultValue => FontSizeEnum.medium;

  static FontSizeEnum from(int enumValue){

    if(enumValue == FontSizeEnum.verySmall.enumValue){
      return FontSizeEnum.verySmall;
    }
    else if(enumValue == FontSizeEnum.small.enumValue){
      return FontSizeEnum.small;
    }
    else if(enumValue == FontSizeEnum.medium.enumValue){
      return FontSizeEnum.medium;
    }
    else if(enumValue == FontSizeEnum.large.enumValue){
      return FontSizeEnum.large;
    }
    else if(enumValue == FontSizeEnum.veryLarge.enumValue){
      return FontSizeEnum.veryLarge;
    }
    return FontSizeEnum.defaultValue;
  }

}