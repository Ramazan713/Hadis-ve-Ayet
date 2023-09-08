import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.
                copyWith(fontWeight: FontWeight.w500,
                fontSize: fontModel.contentFontSize - 1
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 3,),
            getContent(context)
          ],
        ),
      ),
    );
  }

  Widget getContent(BuildContext context){
    if(isArabic){
      return ArabicContentItem(
        content: content,
        fontSize: fontModel.arabicFontSize,
        fontFamily: fontModel.arabicFontFamilyEnum,
      );
    }
    return Text(content,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: fontModel.contentFontSize
      )
    );
  }

}
