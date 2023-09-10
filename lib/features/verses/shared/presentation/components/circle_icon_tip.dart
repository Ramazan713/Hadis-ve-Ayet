import 'package:flutter/material.dart';

class CircleIconTip extends StatelessWidget {

  final Color? iconColor;
  final IconData iconData;
  final double? size;
  final double? borderWith;
  final String message;
  final void Function()? onTap;
  final bool useRipple;

  const CircleIconTip({
    Key? key,
    required this.iconData,
    required this.message,
    this.borderWith,
    this.size,
    this.iconColor,
    this.onTap,
    this.useRipple = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentColor = iconColor ?? Theme.of(context).iconTheme.color;
    final border = borderWith!=null ? Border.all(width: borderWith??1): null;

    return Tooltip(
      message: message,
      child: InkWell(
        onTap: onTap ?? (useRipple ? (){} : null),
        customBorder: const CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: border
          ),
          child: Padding(
              padding: const EdgeInsets.all(1),
              child: Icon(iconData,color: currentColor,)),
        ),
      ),
    );
  }
}
