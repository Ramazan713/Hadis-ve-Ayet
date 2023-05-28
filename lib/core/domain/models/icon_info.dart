

import 'package:flutter/material.dart';

@immutable
class IconInfo{
  final IconData iconData;
  final Color? color;
  final double? size;

  const IconInfo({required this.iconData,this.color,this.size});

  Icon toIcon({Color? color, bool useDefaultOrSet = true}){
    return Icon(iconData,size: size, color: useDefaultOrSet ? this.color ?? color: color,);
  }
}