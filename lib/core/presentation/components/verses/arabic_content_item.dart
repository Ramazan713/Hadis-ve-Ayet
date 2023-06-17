
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/font_family_arabic.dart';
import 'package:hadith/core/presentation/components/verses/s_arabic_content_span.dart';

class ArabicContentItem extends StatelessWidget {

  final String content;
  final double fontSize;
  final int height;
  final FontFamilyArabicEnum fontFamily;

  const ArabicContentItem({
    Key? key,
    required this.content,
    required this.fontSize,
    this.fontFamily = FontFamilyArabicEnum.scheherazadeNew,
    this.height = 2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: sharedArabicContentSpan(
          context,
          content: content,
          fontSize: fontSize,
          height: 2,
          fontFamily: fontFamily
      ),
      textDirection: TextDirection.rtl,);
  }
}
