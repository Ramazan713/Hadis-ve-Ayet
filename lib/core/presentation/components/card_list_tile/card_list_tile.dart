import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_base_list_tile.dart';

class CardListTile extends StatelessWidget {

  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsets? margins;
  final EdgeInsets? contentPadding;
  final bool isSelected;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final double elevation;
  final Color? shadowColor;
  final double? borderWidth;
  final Color? selectedColor;
  final Color? defaultColor;
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;

  const CardListTile({
    super.key,
    this.isSelected = false,
    this.elevation = 1,
    this.shadowColor = Colors.transparent,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.margins,
    this.contentPadding,
    this.onTap,
    this.onLongPress,
    this.borderWidth,
    this.selectedColor,
    this.defaultColor,
    this.borderRadius,
    this.shape
  });

  @override
  Widget build(BuildContext context) {
    final currentBorderRadius = borderRadius ?? BorderRadius.circular(13);

    final currentShape = shape ?? RoundedRectangleBorder(
      borderRadius: currentBorderRadius,
      side: getBorder(context)
    );

    return CardBaseListTile(
      margins: margins,
      isSelected: isSelected,
      elevation: elevation,
      shadowColor: shadowColor,
      selectedColor: selectedColor,
      defaultColor: defaultColor,
      shape: currentShape,
      child: Center(
        child: ListTile(
          shape: currentShape,
          contentPadding: contentPadding,
          title: title,
          subtitle: subtitle,
          onTap: onTap,
          onLongPress: onLongPress,
          trailing: trailing,
          leading: leading,
        ),
      ),
    );
  }


  BorderSide getBorder(BuildContext context){
    if(borderWidth == null) return BorderSide.none;
    return BorderSide(
      color: Theme.of(context).colorScheme.outlineVariant,
      width: borderWidth ?? 1
    );
  }
}
