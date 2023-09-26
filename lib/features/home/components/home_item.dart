import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';


class HomeItem extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final IconData iconData;
  final EdgeInsets? paddings;
  final bool useSecondary;

  const HomeItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
    this.paddings,
    this.useSecondary = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final schema = Theme.of(context).colorScheme;

    final color = useSecondary ? schema.onSecondaryContainer : schema.onPrimaryContainer;
    final backgroundColor = useSecondary ? schema.secondaryContainer : schema.primaryContainer;
    final defaultPaddings = paddings ?? const EdgeInsets.symmetric(vertical: 5);

    return CardListTile(
      margins: defaultPaddings,
      defaultColor: backgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 17,vertical: 3),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: color
        ),
      ),
      leading: Icon(
        iconData,
        color: color,
      ),
      trailing: Icon(Icons.arrow_forward,color: color,),
      onTap: onTap,
      borderWidth: 1,
    );
  }
}
