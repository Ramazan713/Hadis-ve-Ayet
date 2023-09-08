

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';



TextSpan sharedArabicContentSpan(
    BuildContext context, {
      required String content,
      FontFamilyArabicEnum fontFamily = FontFamilyArabicEnum.scheherazadeNew,
      int height = 2,
      double? fontSize,
      FontWeight fontWeight = FontWeight.normal
    }){

  return TextSpan(
      text: content,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: fontFamily.fontName,
          height: 2.0,
          fontSize: fontSize,
          fontWeight: fontWeight
      ),
  );
}