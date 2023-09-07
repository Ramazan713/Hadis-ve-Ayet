import 'package:flutter/material.dart';

class IconTextItem extends StatelessWidget {

  final IconData iconData;
  final String title;
  final double iconSize;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? titleStyle;
  final EdgeInsets? margins;
  final double iconTextDistance;

  const IconTextItem({
    super.key,
    required this.iconData,
    required this.title,
    this.iconSize = 30,
    this.iconTextDistance = 12,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.titleStyle,
    this.margins
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margins ?? const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Icon(
            iconData,
            size: iconSize,
          ),
          SizedBox(width: iconTextDistance,),
          Flexible(
            child: Text(
              title,
              style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
