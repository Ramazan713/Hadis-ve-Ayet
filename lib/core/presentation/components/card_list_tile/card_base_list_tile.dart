import 'package:flutter/material.dart';

class CardBaseListTile extends StatelessWidget {
  final EdgeInsets? margins;
  final bool isSelected;
  final double elevation;
  final Color? shadowColor;
  final Widget child;
  final Color? selectedColor;
  final Color? defaultColor;
  final ShapeBorder? shape;

  const CardBaseListTile({
    super.key,
    required this.child,
    this.isSelected = false,
    this.elevation = 1,
    this.shadowColor = Colors.transparent,
    this.margins,
    this.selectedColor,
    this.defaultColor,
    this.shape
  });

  @override
  Widget build(BuildContext context) {

    final colorSchema = Theme.of(context).colorScheme;
    final color = isSelected ? (selectedColor ?? colorSchema.secondaryContainer)
        : (defaultColor ?? colorSchema.surface);

    return Card(
      margin: margins ?? const EdgeInsets.symmetric(),
      color: color,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      child: child,
    );
  }
}