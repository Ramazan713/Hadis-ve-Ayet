import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';
import 'package:hadith/core/presentation/components/verses/s_arabic_content_span.dart';
import 'package:hadith/core/domain/models/verse/verse_arabic.dart';
import 'package:hadith/core/utils/asset_helper.dart';

class VerseArabicContentItem extends StatelessWidget {

  final List<VerseArabic> verseArabics;
  final double fontSize;
  final FontFamilyArabicEnum fontFamily;
  final FontWeight fontWeight;

  const VerseArabicContentItem({
    Key? key,
    required this.verseArabics,
    required this.fontSize,
    this.fontFamily = FontFamilyArabicEnum.scheherazadeNew,
    this.fontWeight = FontWeight.normal
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final textHeight = getSize(sharedArabicContentSpan(context,
        content: "test",
        fontSize: fontSize,
        fontFamily: fontFamily
    )).height / 3;

    final children=<InlineSpan>[];
    final verseStopImg = Image.asset(
        AssetHelper.verseStop,
        width: textHeight + 7,
        height: textHeight + 3
    ); //,

    for(var arabicVerse in verseArabics){
      children.add(
          TextSpan(
            children: [
              sharedArabicContentSpan(
                  context,
                  content: arabicVerse.verse,
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                  fontWeight: fontWeight
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(width: textHeight ,),
                    verseStopImg,
                    Text(arabicVerse.verseNumber,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: textHeight - 5
                      ),),
                  ],
                )
              ),
            ],
          )
      );
    }
    return RichText(
      textScaleFactor: fontFamily.textScaleFactor,
      text: TextSpan(children: children),
      textDirection: TextDirection.rtl,
    );
  }

  Size getSize(TextSpan textSpan){
    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.rtl,
    )..layout();
    return textPainter.size;
  }
}


