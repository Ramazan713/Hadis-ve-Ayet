import 'package:flutter/material.dart';


class TitleTextItem extends StatelessWidget {
  final String title;
  final String content;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final BorderSide?borderSide;
  final double elevation;
  const TitleTextItem({Key? key,required this.title,required this.content,this.margin,
    this.titleTextStyle,this.contentTextStyle,this.borderSide,this.padding,this.elevation=3
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13),
            side: borderSide??BorderSide(width: 2,color: Theme.of(context).primaryColorDark)
        ),
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Padding(
          padding: padding??const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
          child: Row(
            textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(title,
                style: titleTextStyle??Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 7,),
              Expanded(
                child: Text(content,
                  style: contentTextStyle??Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );;
  }
}
