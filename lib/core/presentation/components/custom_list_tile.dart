import 'package:flutter/material.dart';


class CustomListTile extends StatelessWidget {

  final void Function()? onTap;
  final String title;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  late final ShapeBorder shapeBorder;

  CustomListTile({
    Key? key,
    this.onTap,
    required this.title,
    this.leading,
    this.subTitle,
    this.trailing,
    ShapeBorder? shapeBorder
  }) : super(key: key){
    this.shapeBorder = shapeBorder ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
    );
  }

  Widget? getSubTitle(BuildContext context){
    if(subTitle == null) return null;

    return Text(
      subTitle??"",
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: shapeBorder,
      leading: leading,
      trailing: trailing,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: getSubTitle(context),
      onTap: onTap,
    );
  }
}
