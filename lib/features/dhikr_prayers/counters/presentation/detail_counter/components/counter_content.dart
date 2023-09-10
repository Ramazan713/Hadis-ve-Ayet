import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';

class CounterContent extends StatelessWidget {
  final String title;
  final String content;
  final FontModel fontModel;
  final bool isArabic;

  const CounterContent({
    Key? key,
    required this.title,
    required this.content,
    required this.fontModel,
    this.isArabic = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(isArabic){
      return TitleSectionChild(
        title: title,
        useDefaultColor: true,
        elevation: 3,
        contentFontSize: fontModel.contentFontSize,
        margins: const EdgeInsets.symmetric(vertical: 6),
        content: ArabicContentItem(
          content: content,
          fontSize: fontModel.arabicFontSize,
          fontFamily: fontModel.arabicFontFamilyEnum,
        )
      );
    }

    return TitleSectionItem(
      title: title,
      content: content,
      useDefaultColor: true,
      elevation: 3,
      contentFontSize: fontModel.contentFontSize,
      margins: const EdgeInsets.symmetric(vertical: 6),
    );
  }
}
