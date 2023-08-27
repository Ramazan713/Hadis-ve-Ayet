

import 'package:flutter/material.dart';

class IconTextItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final double width;
  final TextStyle? style;
  const IconTextItem({Key? key,required this.iconData,required this.title,this.width=7,this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData),
        SizedBox(
          width: width,
        ),
        Text(
          title,
          style: style??Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
