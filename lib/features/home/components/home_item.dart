import 'package:flutter/material.dart';


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

    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant
        )
    );

    final defaultPaddings = paddings ?? const EdgeInsets.symmetric(vertical: 5);

    return Padding(
      padding: defaultPaddings,
      child: ListTile(
        tileColor: backgroundColor,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: color
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 17,vertical: 3),
        leading: Icon(
          iconData,
          color: color,
        ),
        shape: shape,
        trailing: Icon(Icons.arrow_forward,color: color,),
        onTap: onTap,
      ),
    );
  }
}
