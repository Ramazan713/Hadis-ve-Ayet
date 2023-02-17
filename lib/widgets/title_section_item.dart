import 'package:flutter/material.dart';



class TitleSectionItem extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double?elevation;
  final BorderSide? borderSide;
  final TextStyle? titleStyle;
  const TitleSectionItem({Key? key,required this.title,required this.child,
    this.margin,this.elevation=3,this.borderSide,this.padding,this.titleStyle
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: Text(title,
                  style: titleStyle??Theme.of(context).textTheme.titleLarge,
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}