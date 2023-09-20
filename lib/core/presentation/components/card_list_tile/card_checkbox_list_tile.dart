import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_base_list_tile.dart';

class CardCheckboxListTile extends StatelessWidget {

  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsets? margins;
  final bool isSelected;
  final bool isSelectedCard;
  final void Function(bool?)? onChanged;
  final double elevation;
  final Color? shadowColor;
  final double? borderWidth;

  const CardCheckboxListTile({
    super.key,
    this.isSelected = false,
    this.isSelectedCard = false,
    this.elevation = 1,
    this.shadowColor = Colors.transparent,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.margins,
    this.onChanged,
    this.borderWidth
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(13);

    final shape = RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: getBorder(context)
    );

    return CardBaseListTile(
      margins: margins,
      isSelected: isSelectedCard,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      child: CheckboxListTile(
        shape: shape,
        value: isSelected,
        selected: isSelected,
        title: title,
        subtitle: subtitle,
        onChanged: onChanged,
      ),
    );
  }


  BorderSide getBorder(BuildContext context){
    if(borderWidth == null) return BorderSide.none;
    return BorderSide(
        color: Theme.of(context).colorScheme.outline,
        width: borderWidth ?? 1
    );
  }
}
