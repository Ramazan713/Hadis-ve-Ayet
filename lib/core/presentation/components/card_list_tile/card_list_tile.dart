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
  final double elevation;
  final Color? shadowColor;
  final double? borderWidth;
  final Color? selectedColor;
  final Color? defaultColor;
  final BorderRadius? borderRadius;

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
    this.borderWidth,
    this.selectedColor,
    this.defaultColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final currentBorderRadius = borderRadius ?? BorderRadius.circular(13);

    final shape = RoundedRectangleBorder(
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
      shape: shape,
      child: ListTile(
        shape: shape,
        contentPadding: contentPadding,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        trailing: trailing,
        leading: leading,
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
