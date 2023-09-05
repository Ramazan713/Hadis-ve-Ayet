import 'package:flutter/material.dart';


class TitleTextItem extends StatelessWidget {
  final String title;
  final String content;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final double? contentFontSize;

  const TitleTextItem({
    Key? key,
    required this.title,
    required this.content,
    this.margin,
    this.padding,
    this.titleTextStyle,
    this.contentTextStyle,
    this.contentFontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
        child: Row(
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(title,
              style: titleTextStyle ?? Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: contentFontSize
              ),
            ),
            const SizedBox(width: 7,),
            Expanded(
              child: Text(content,
                style: contentTextStyle ?? Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: contentFontSize
                ),
              ),
            )
          ],
        ),
      ),
    );;
  }
}
