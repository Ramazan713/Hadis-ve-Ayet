import 'package:flutter/material.dart';

class SharedHeader extends StatelessWidget {

  final void Function() onClose;
  final String title;
  final IconData? iconData;
  final TextStyle? titleStyle;
  final TextAlign? textAlign;

  const SharedHeader({
    super.key,
    required this.title,
    required this.onClose,
    this.iconData,
    this.textAlign,
    this.titleStyle
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            title,
            style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
            textAlign: textAlign ?? TextAlign.center,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: onClose,
            icon: Icon(iconData ?? Icons.close),
          ),
        )
      ],
    );
  }
}
